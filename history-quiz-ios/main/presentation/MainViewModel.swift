//
// Created by Dmitrii Permiakov on 10/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    private var repository: BalanceRepository
    private var disposables = Set<AnyCancellable>()

    @Published
    var awardInfo: AwardInfo? = nil
    @Published
    var showAwardAlert = false

    init(repository: BalanceRepository) {
        self.repository = repository
        let lastDailyBalance = repository.lastDailyAwardDate
        if lastDailyBalance == nil {
            let transaction = Transaction.create(.startAward)
            updateDailyAward(transaction)
        } else {
            let diff = Calendar.current.dateComponents([.hour], from: lastDailyBalance!, to: Date())
            if let hours = diff.hour, hours > 24 {
                let transaction = Transaction.create(.dailyAward)
                updateDailyAward(transaction)
            }
        }
    }

    private func updateDailyAward(_ transaction: Transaction) {
        switch transaction.type {
        case .dailyAward:
            awardInfo = AwardInfo(
                    title: "Daily reward".localized(),
                    description: "You receive your new daily reward! Congrats!".localized(),
                    confirmButton: String(format: "Get with param".localized(), String(transaction.type.amount))
            )
        case .startAward:
            awardInfo = AwardInfo(
                    title: "Money".localized(),
                    description: "You can use money to spend and collect them!".localized(),
                    confirmButton: String(format: "Get with param".localized(), String(transaction.type.amount))
            )
        default:
            awardInfo = nil
        }
        self.showAwardAlert = true

        self.repository.lastDailyAwardDate = Date()
        self.repository.createTransaction(value: transaction)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink { success in
                    print("transaction \(transaction) was created")
                }
                .store(in: &disposables)
    }
}

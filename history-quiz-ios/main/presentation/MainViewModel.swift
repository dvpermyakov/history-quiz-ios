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
            let transaction = Transaction.create(.StartAward)
            updateDailyAward(transaction)
        } else {
            let diff = Calendar.current.dateComponents([.hour], from: lastDailyBalance!, to: Date())
            if let hours = diff.hour, hours > 24 {
                let transaction = Transaction.create(.DailyAward)
                updateDailyAward(transaction)
            }
        }
    }

    private func updateDailyAward(_ transaction: Transaction) {
        switch transaction.type {
        case .DailyAward:
            awardInfo = AwardInfo(
                    title: "Daily reward",
                    description: "You receive your new daily reward! Congrats!",
                    confirmButton: "Get: \(transaction.type.amount)"
            )
        case .StartAward:
            awardInfo = AwardInfo(
                    title: "Money",
                    description: "You can use money to spend and collect them!",
                    confirmButton: "Get: \(transaction.type.amount)"
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

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
    var showDailyAwardAlert = false

    init(repository: BalanceRepository) {
        self.repository = repository
        let lastDailyBalance = repository.lastDailyAwardDate
        if lastDailyBalance == nil {
            updateDailyAward()
        } else {
            let diff = Calendar.current.dateComponents([.hour], from: lastDailyBalance!, to: Date())
            if let hours = diff.hour, hours > 24 {
                updateDailyAward()
            }
        }
    }

    private func updateDailyAward() {
        self.showDailyAwardAlert = true
        self.repository.lastDailyAwardDate = Date()
        let transaction = Transaction(
                id: UUID(),
                amount: 30,
                date: Date(),
                type: Transaction.TransactionType.DailyAward
        )
        self.repository.createTransaction(value: transaction)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink { success in
                    print("transaction \(transaction) was created")
                }
                .store(in: &disposables)
    }
}

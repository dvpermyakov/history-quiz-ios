//
// Created by Dmitrii Permiakov on 10/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

class MainViewModel: ObservableObject {

    private var repository: BalanceRepository

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
        self.repository.createTransaction(
                value: Transaction(
                        id: UUID(),
                        amount: 30,
                        date: Date(),
                        type: Transaction.TransactionType.DailyAward
                )
        )
    }
}

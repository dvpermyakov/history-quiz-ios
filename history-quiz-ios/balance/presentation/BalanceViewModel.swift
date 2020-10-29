//
// Created by Dmitrii Permiakov on 10/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

class BalanceViewModel: ObservableObject {

    private let repository: BalanceRepository

    @Published
    var transactions: [Transaction] = []

    init(repository: BalanceRepository) {
        self.repository = repository
        let transaction = Transaction(
                id: UUID(),
                amount: 30,
                date: Date(),
                type: Transaction.TransactionType.DailyAward
        )
        self.transactions = repository.getAllTransactions()
    }

}

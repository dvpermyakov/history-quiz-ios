//
// Created by Dmitrii Permiakov on 10/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

class BalanceViewModel: ObservableObject {

    private let repository: BalanceRepository

    @Published
    var balanceSum: Int = 0

    @Published
    var receiveBonusesInfo: CommonListUiModel? = nil
    @Published
    var spendBonusesInfo: CommonListUiModel? = nil

    @Published
    var transactions: [Transaction] = []

    init(repository: BalanceRepository) {
        self.repository = repository
        self.transactions = repository.getAllTransactions()

        balanceSum = transactions.map { transaction in
            transaction.amount
        }.reduce(0, +)

        receiveBonusesInfo = CommonListUiModel(list: [
            CommonListUiModel.Item(name: "Daily bonus", value: "30"),
            CommonListUiModel.Item(name: "Open article by link", value: "5"),
            CommonListUiModel.Item(name: "Read article", value: "5"),
            CommonListUiModel.Item(name: "Finish test", value: "30")
        ])
        spendBonusesInfo = CommonListUiModel(list: [
            CommonListUiModel.Item(name: "Open any article", value: "10"),
            CommonListUiModel.Item(name: "Start closed test", value: "20"),
            CommonListUiModel.Item(name: "Continue test", value: "30")
        ])
    }

}

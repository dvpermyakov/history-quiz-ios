//
// Created by Dmitrii Permiakov on 10/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

class BalanceViewModel: ObservableObject {

    private let repository: BalanceRepository

    @Published
    var balanceSum: String = ""

    @Published
    var receiveBonusesInfo: CommonListUiModel? = nil
    @Published
    var spendBonusesInfo: CommonListUiModel? = nil

    @Published
    var transactionsInfo: CommonListUiModel? = nil

    init(repository: BalanceRepository) {
        self.repository = repository
        updateTransactions()
    }

    func onAppear() {
        updateTransactions()
    }

    func onDisappear() {
        // todo: need to implement by disposable
    }

    private func updateTransactions() {
        let transactions = repository.getAllTransactions()

        balanceSum = String(
                transactions.map { transaction in
                    transaction.amount
                }.reduce(0, +)
        )

        receiveBonusesInfo = CommonListUiModel(list: [
            CommonListUiModel.Item(name: "Daily bonus".localized(), value: "30"),
            CommonListUiModel.Item(name: "Open article by link".localized(), value: "5"),
            CommonListUiModel.Item(name: "Read article".localized(), value: "5"),
            CommonListUiModel.Item(name: "Finish test".localized(), value: "30")
        ])
        spendBonusesInfo = CommonListUiModel(list: [
            CommonListUiModel.Item(name: "Open any article".localized(), value: "10"),
            CommonListUiModel.Item(name: "Start closed test".localized(), value: "20"),
            CommonListUiModel.Item(name: "Continue test".localized(), value: "30")
        ])
        transactionsInfo = CommonListUiModel(list: transactions.map { transaction in
            CommonListUiModel.Item(name: transaction.typeTitle, value: "+\(transaction.amount)")
        })
    }

}

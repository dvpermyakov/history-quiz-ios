//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

class ArticleViewModel: ObservableObject {
    private let articleRepository: ArticleRepository
    private let balanceRepository: BalanceRepository
    private var disposables = Set<AnyCancellable>()

    @Published
    var article: Article? = nil

    @Published
    var testInfo: CommonListUiModel? = nil

    @Published
    var haveRead: Bool = false

    init(
            id: String,
            category: String,
            articleRepository: ArticleRepository,
            balanceRepository: BalanceRepository
    ) {
        self.articleRepository = articleRepository
        self.balanceRepository = balanceRepository
        articleRepository.getArticle(id: id, category: category)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    print("getArticle \(completion)")
                }, receiveValue: { output in
                    self.article = output
                    let test = output.test
                    self.testInfo = CommonListUiModel(list: [
                        CommonListUiModel.Item(name: "Question amount".localized(), value: String(test.questionAmount)),
                        CommonListUiModel.Item(name: "Available seconds".localized(), value: String(test.seconds)),
                        CommonListUiModel.Item(name: "Lives amount".localized(), value: String(test.mistakesAmount))
                    ])
                })
                .store(in: &disposables)
    }

    func onReadClick() {
        if (!self.haveRead) {
            self.haveRead = true
            balanceRepository.createTransaction(
                    value: Transaction(
                            id: UUID(),
                            amount: 5,
                            date: Date(),
                            type: Transaction.TransactionType.ArticleRead
                    )
            )
        }
    }

}
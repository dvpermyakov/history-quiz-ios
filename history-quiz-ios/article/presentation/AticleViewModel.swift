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

    private let articleId: String
    private let articleCategory: String

    @Published
    var article: Article? = nil
    @Published
    var openArticleDescription: Bool = false
    @Published
    var articleDescription: ArticleDescription? = nil
    @Published
    var error: String? = nil
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
        self.articleId = id
        self.articleCategory = category
        self.articleRepository = articleRepository
        self.balanceRepository = balanceRepository

        articleRepository.getArticle(id: id, category: category)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        return
                    case .failure(let er):
                        self.error = er.localizedDescription
                    }
                }, receiveValue: { article in
                    self.article = article
                    let test = article.test
                    self.testInfo = CommonListUiModel(list: [
                        CommonListUiModel.Item(name: "Question amount".localized(), value: String(test.questionAmount)),
                        CommonListUiModel.Item(name: "Available seconds".localized(), value: String(test.seconds)),
                        CommonListUiModel.Item(name: "Lives amount".localized(), value: String(test.mistakesAmount))
                    ])
                })
                .store(in: &disposables)

        articleRepository.getReadArticle(articleId: id, articleCategory: category)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink { readArticle in
                    self.haveRead = readArticle != nil
                }
                .store(in: &disposables)
    }

    func onReadClick() {
        if (!self.haveRead) {
            self.haveRead = true
            let transaction = Transaction(
                    id: UUID(),
                    amount: 5,
                    date: Date(),
                    type: Transaction.TransactionType.ArticleRead
            )
            balanceRepository.createTransaction(value: transaction)
                    .subscribe(on: DispatchQueue.global())
                    .receive(on: DispatchQueue.main)
                    .sink { success in
                        print("transaction \(transaction) was created")
                    }
                    .store(in: &disposables)
            let readArticle = ReadArticle(
                    id: UUID(),
                    articleId: articleId,
                    articleCategory: articleCategory,
                    date: Date()
            )
            articleRepository.setReadArticle(item: readArticle)
                    .subscribe(on: DispatchQueue.global())
                    .receive(on: DispatchQueue.main)
                    .sink { success in
                        print("readArticle \(readArticle) was created")
                    }
                    .store(in: &disposables)
        }
    }

    func onLinkClick(articleId: String, articleCategory: String) {
        self.openArticleDescription = true
        let openedArticle = OpenedArticle(
                id: UUID(),
                articleId: articleId,
                articleCategory: articleCategory,
                date: Date()
        )
        loadArticleDescription(openedArticle)
        articleRepository.getOpenedArticle(
                        articleId: articleId,
                        articleCategory: articleCategory
                )
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink { savedOpenedArticle in
                    if (savedOpenedArticle == nil) {
                        self.saveOpenedArticle(openedArticle)
                    }
                }
                .store(in: &disposables)
    }

    private func loadArticleDescription(_ article: OpenedArticle) {
        if let foundEvent = self.article?.events.first(where: { event in
            event.id == article.articleId && event.category == article.articleCategory
        }) {
            self.articleDescription = foundEvent
        } else if let foundPerson = self.article?.persons.first(where: { person in
            person.id == article.articleId && person.category == article.articleCategory
        }) {
            self.articleDescription = foundPerson
        } else {
            self.articleRepository.getArticleInfo(id: article.articleId, category: article.articleCategory)
                    .subscribe(on: DispatchQueue.global())
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                    }, receiveValue: { articleInfo in
                        self.articleDescription = articleInfo
                    })
                    .store(in: &disposables)
        }
    }

    private func saveOpenedArticle(_ article: OpenedArticle) {
        articleRepository.setOpenedArticle(item: article)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink { success in
                    print("openedArticle \(article) was created")
                }
                .store(in: &disposables)
    }

}
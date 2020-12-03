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
    private(set) var article: Article? = nil
    @Published
    var openArticleClarification: Bool = false
    @Published
    private(set) var articleClarification: ArticleClarificationUiModel? = nil
    @Published
    private(set) var error: String? = nil
    @Published
    private(set) var testInfo: CommonListUiModel? = nil
    @Published
    private(set) var haveRead: Bool = false

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
                    if case let .failure(er) = completion {
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
            let transaction = Transaction.create(.articleRead)
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
        self.openArticleClarification = true
        let openedArticle = OpenedArticle(
                id: UUID(),
                articleId: articleId,
                articleCategory: articleCategory,
                date: Date()
        )
        articleRepository.getOpenedArticle(
                        articleId: articleId,
                        articleCategory: articleCategory
                )
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink { savedOpenedArticle in
                    self.loadArticleDescription(
                            article: openedArticle,
                            newArticle: savedOpenedArticle == nil
                    )
                    if (savedOpenedArticle == nil) {
                        self.saveOpenedArticle(openedArticle)
                    }
                }
                .store(in: &disposables)
    }

    private func loadArticleDescription(
            article: OpenedArticle,
            newArticle: Bool
    ) {
        if let foundEvent = self.article?.events.first(where: { event in
            event.id == article.articleId && event.category == article.articleCategory
        }) {
            self.articleClarification = ArticleClarificationUiModel(
                    article: foundEvent,
                    newArticle: newArticle
            )
        } else if let foundPerson = self.article?.persons.first(where: { person in
            person.id == article.articleId && person.category == article.articleCategory
        }) {
            self.articleClarification = ArticleClarificationUiModel(
                    article: foundPerson,
                    newArticle: newArticle
            )
        } else {
            self.articleRepository.getArticleInfo(id: article.articleId, category: article.articleCategory)
                    .subscribe(on: DispatchQueue.global())
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                    }, receiveValue: { articleInfo in
                        self.articleClarification = ArticleClarificationUiModel(
                                article: articleInfo,
                                newArticle: newArticle
                        )
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
        let transaction = Transaction.create(.articleOpened)
        balanceRepository.createTransaction(value: transaction)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink { success in
                    print("transaction \(transaction) was created")
                }
                .store(in: &disposables)
    }

}
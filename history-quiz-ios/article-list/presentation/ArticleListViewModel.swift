//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import Combine

class ArticleListViewModel: ObservableObject {
    private let articleRepository: ArticleRepository
    private var disposables = Set<AnyCancellable>()

    @Published
    var newArticles: NewArticles? = nil

    init(articleRepository: ArticleRepository) {
        self.articleRepository = articleRepository
        self.loadNewArticles()
    }

    private func loadNewArticles() {
        articleRepository.getNewArticles()
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                }, receiveValue: { newArticles in
                    self.newArticles = newArticles
                })
                .store(in: &disposables)
    }
}

//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

class ArticleViewModel: ObservableObject {
    private let repository = ArticleRepository()
    private var disposables = Set<AnyCancellable>()

    @Published
    var article: Article? = nil

    init(id: String, category: String) {
        repository.getArticle(id: id, category: category)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    print("getArticle \(completion)")
                }, receiveValue: { output in
                    self.article = output
                })
                .store(in: &disposables)
    }

}
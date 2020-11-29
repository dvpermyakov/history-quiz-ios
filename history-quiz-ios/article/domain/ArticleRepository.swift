//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

protocol ArticleRepository {
    func setReadArticle(item: ReadArticle) -> Bool

    func getReadArticle(articleId: String, articleCategory: String) -> ReadArticle?

    func getArticle(id: String, category: String) -> AnyPublisher<Article, Error>
}

//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

protocol ArticleRepository {
    func setReadArticle(item: ReadArticle) -> AnyPublisher<Bool, Never>

    func getReadArticle(articleId: String, articleCategory: String) -> AnyPublisher<ReadArticle?, Never>

    func setOpenedArticle(item: OpenedArticle) -> AnyPublisher<Bool, Never>

    func getOpenedArticle(articleId: String, articleCategory: String) -> AnyPublisher<OpenedArticle?, Never>

    func getArticle(id: String, category: String) -> AnyPublisher<Article, Error>

    func getArticleInfo(id: String, category: String) -> AnyPublisher<ArticleInfo, Error>
}

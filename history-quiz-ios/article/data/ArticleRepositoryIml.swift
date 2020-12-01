//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine
import CoreData

class ArticleRepositoryIml: ArticleRepository {
    private let PATH_GAME = "/api/history/mark_info"

    func setReadArticle(item: ReadArticle) -> AnyPublisher<Bool, Never> {
        Future<Bool, Never> { promise in
            guard let context = getArticleContext() else {
                return promise(.success(false))
            }
            item.setEntity(for: context)
            try? context.save()
            return promise(.success(true))
        }.eraseToAnyPublisher()
    }

    func getReadArticle(articleId: String, articleCategory: String) -> AnyPublisher<ReadArticle?, Never> {
        Future<ReadArticle?, Never> { promise in
            guard let context = getArticleContext() else {
                return promise(.success(nil))
            }
            let request = NSFetchRequest<ReadArticleEntity>(entityName: "ReadArticleEntity")
            request.predicate = NSPredicate(format: "articleId = %@ AND articleCategory = %@", articleId, articleCategory)
            return promise(.success(try? context.fetch(request).first?.map()))
        }.eraseToAnyPublisher()
    }

    func setOpenedArticle(item: OpenedArticle) -> AnyPublisher<Bool, Never> {
        Future<Bool, Never> { promise in
            guard let context = getArticleContext() else {
                return promise(.success(false))
            }
            item.setEntity(for: context)
            try? context.save()
            return promise(.success(true))
        }.eraseToAnyPublisher()
    }

    func getOpenedArticle(articleId: String, articleCategory: String) -> AnyPublisher<OpenedArticle?, Never> {
        Future<OpenedArticle?, Never> { promise in
            guard let context = getArticleContext() else {
                return promise(.success(nil))
            }
            let request = NSFetchRequest<OpenedArticleEntity>(entityName: "OpenedArticleEntity")
            request.predicate = NSPredicate(format: "articleId = %@ AND articleCategory = %@", articleId, articleCategory)
            return promise(.success(try? context.fetch(request).first?.map()))
        }.eraseToAnyPublisher()
    }

    func getArticle(id: String, category: String) -> AnyPublisher<Article, Error> {
        var components = URLComponents(string: NetworkConfig.BASE_URL + PATH_GAME)
        components?.queryItems = [
            URLQueryItem(name: "mark_id", value: id),
            URLQueryItem(name: "category", value: category)
        ]
        guard let url = components?.url else {
            return Fail(error: UrlNotFoundError()).eraseToAnyPublisher()
        }
        return URLSession.shared
                .dataTaskPublisher(for: URLRequest(url: url))
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw APIError()
                    }
                    return element.data
                }
                .decode(type: ArticleDto.self, decoder: JSONDecoder())
                .map { dto in
                    dto.map()
                }
                .eraseToAnyPublisher()
    }
}

//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

class ArticleRepository {
    private let PATH_GAME = "/api/history/mark_info"

    func getArticle(id: String, category: String) -> AnyPublisher<Article, Error> {
        let url = URL(string: "\(NetworkConfig.BASE_URL)\(PATH_GAME)?mark_id=\(id)&category=\(category)")!
        let urlRequest = URLRequest(url: url)
        return URLSession.shared
                .dataTaskPublisher(for: urlRequest)
                .tryMap() { element -> Data in
                    print(element.response)
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

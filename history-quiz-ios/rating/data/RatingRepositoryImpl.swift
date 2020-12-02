//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Combine
import Foundation

class RatingRepositoryImpl: RatingRepository {
    private let PATH_RATING = "/api/rating/list"

    func getUserRating() -> AnyPublisher<[User], Error> {
        let components = URLComponents(string: NetworkConfig.BASE_URL + PATH_RATING)
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
                .decode(type: RatingDto.self, decoder: JSONDecoder())
                .map { dto in
                    dto.map()
                }
                .eraseToAnyPublisher()
    }

}

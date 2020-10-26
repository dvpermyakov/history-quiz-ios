//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

class PeriodsRepositoryIml: PeriodsRepository {

    private let PATH_PERIODS = "/api/history/periods"

    func getPeriods() -> AnyPublisher<[Period], Error> {
        var components = URLComponents(string: NetworkConfig.BASE_URL + PATH_PERIODS)
        components?.queryItems = [
            URLQueryItem(name: "country_id", value: NetworkConfig.COUNTRY_ID)
        ]
        guard let url = components?.url else {
            return AnyPublisher<[Period], Error>(Empty())
        }
        return URLSession.shared
                .dataTaskPublisher(for: URLRequest(url: url))
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw APIError()
                    }
                    return element.data
                }
                .decode(type: PeriodsDto.self, decoder: JSONDecoder())
                .map { periodsDto in
                    periodsDto.periods.map { dto in
                        dto.map()
                    }
                }
                .eraseToAnyPublisher()
    }
}
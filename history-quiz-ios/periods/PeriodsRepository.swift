//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

class PeriodsRepository {

    private let PATH_PERIODS = "/api/history/periods"

    func getPeriods() -> AnyPublisher<[Period], Error> {
        let url = URL(string: "\(NetworkConfig.BASE_URL)\(PATH_PERIODS)?country_id=\(NetworkConfig.COUNTRY_ID)")!
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
                .decode(type: PeriodsDto.self, decoder: JSONDecoder())
                .map { periodsDto in
                    periodsDto.periods.map { dto in
                        dto.map()
                    }
                }
                .eraseToAnyPublisher()
    }
}
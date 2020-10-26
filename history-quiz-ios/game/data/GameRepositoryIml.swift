//
//  GameRepositoryIml.swift
//  history-quiz-ios
//
//  Created by Dmitrii Permiakov on 10/25/20.
//  Copyright © 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

class GameRepositoryIml: GameRepository {

    private let PATH_GAME = "/api/test/questions"

    func getGame(gameId: String) -> AnyPublisher<Game, Error> {
        let url = URL(string: "\(NetworkConfig.BASE_URL)\(PATH_GAME)?test_id=\(gameId)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        return URLSession.shared
                .dataTaskPublisher(for: urlRequest)
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw APIError()
                    }
                    return element.data
                }
                .decode(type: GameDto.self, decoder: JSONDecoder())
                .map { dto in
                    dto.map()
                }
                .eraseToAnyPublisher()
    }
}

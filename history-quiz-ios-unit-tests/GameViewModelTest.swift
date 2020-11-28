//
//  GameViewModelTest.swift
//  history-quiz-ios
//
//  Created by Dmitrii Permiakov on 11/28/20.
//  Copyright © 2020 Dmitrii Permiakov. All rights reserved.
//

import XCTest
@testable
import history_quiz_ios
import Combine

class FakeGameRepository: GameRepository {
    func getGame(gameId: String) -> AnyPublisher<Game, Error> {
        AnyPublisher<Game, Error>(Empty())
    }
}

class GameViewModelTest: XCTestCase {

    func testGameResultEmpty() throws {
        let test = createTest()
        let model = GameViewModel(
                test: test,
                repository: FakeGameRepository()
        )
        XCTAssertNil(model.gameResult)
    }

    private func createTest() -> Test {
        Test(
                id: "id",
                questionAmount: 1,
                mistakesAmount: 1,
                seconds: 10
        )
    }

}

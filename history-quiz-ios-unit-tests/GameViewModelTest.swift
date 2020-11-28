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

class GameViewModelTest: XCTestCase {

    class FakeGameRepository: GameRepository {
        let game: Game

        init(game: Game) {
            self.game = game
        }

        func getGame(gameId: String) -> AnyPublisher<Game, Error> {
            Result<Game, Error>.Publisher(game).eraseToAnyPublisher()
        }
    }

    func test_chooseWrongAnswer() throws {
        let test = createTest()
        let game = createGame()
        let model = GameViewModel(
                test: test,
                repository: FakeGameRepository(game: game)
        )

        let wrongAnswer = game.questions[0].answers[0]
        model.setAnswer(answer: wrongAnswer)

        model.$gameResult.assert(results: [nil])
        model.$wrongAnswers.assert(results: [[wrongAnswer]])
        model.$rightAnswer.assert(results: [nil])
    }

    func test_chooseRightAnswer() throws {
        let test = createTest()
        let game = createGame()
        let model = GameViewModel(
                test: test,
                repository: FakeGameRepository(game: game)
        )

        let rightAnswer = game.questions[0].answers[3]
        model.setAnswer(answer: rightAnswer)

        model.$gameResult.assert(results: [createWinResult(test: test)])
        model.$wrongAnswers.assert(results: [[]])
        model.$rightAnswer.assert(results: [nil])
    }

    private func createTest() -> Test {
        Test(
                id: "id",
                questionAmount: 1,
                mistakesAmount: 1,
                seconds: 10
        )
    }

    private func createGame() -> Game {
        Game(questions: [
            Game.Question(text: "?", answers: [
                Game.Answer(id: "1", text: "1", correct: false),
                Game.Answer(id: "2", text: "2", correct: false),
                Game.Answer(id: "3", text: "3", correct: false),
                Game.Answer(id: "4", text: "4", correct: true),
            ])
        ])
    }

    private func createWinResult(test: Test) -> GameResult {
        GameResult(
                test: test,
                questionsAnswered: 0,
                timeConsumed: 0,
                mistakesMade: 0
        )
    }
}

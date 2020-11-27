//
//  GameViewModel.swift
//  history-quiz-ios
//
//  Created by Dmitrii Permiakov on 10/8/20.
//  Copyright © 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {

    private let repository: GameRepository
    private var disposables = Set<AnyCancellable>()
    private var timer: Timer? = nil

    private let test: Test
    @Published
    private var game: Game? = nil
    @Published
    private var questionIndex = 0
    @Published
    private var currentSeconds = 0
    @Published
    private var mistakeAmount = 0

    @Published
    var wrongAnswers: [Game.Answer] = []
    @Published
    var rightAnswer: Game.Answer? = nil
    @Published
    var gameResult: GameResult? = nil

    var currentQuestion: Game.Question? {
        game?.questions[questionIndex]
    }
    var secondsLeft: Int {
        test.seconds - currentSeconds
    }
    var questionNumber: Int {
        questionIndex + 1
    }
    var questionMax: Int {
        game?.questions.endIndex ?? 0
    }
    var mistakeLeft: Int {
        test.mistakesAmount - mistakeAmount
    }

    init(test: Test, repository: GameRepository) {
        self.test = test
        self.repository = repository
        repository.getGame(gameId: test.id)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                }, receiveValue: { output in
                    self.game = output
                })
                .store(in: &disposables)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if (self.gameResult == nil) {
                self.currentSeconds += 1
                if (self.currentSeconds >= self.test.seconds) {
                    self.endGame()
                }
                if (self.mistakeAmount >= self.test.mistakesAmount) {
                    self.endGame()
                }
                if (self.rightAnswer != nil) {
                    self.nextQuestion()
                }
            }
        }
    }

    func setAnswer(answer: Game.Answer) {
        if let game = self.game {
            if answer.correct {
                if questionIndex + 1 < game.questions.endIndex {
                    rightAnswer = answer
                } else {
                    endGame()
                }
            } else {
                mistakeAmount += 1
                wrongAnswers.append(answer)
            }
        }
    }

    func restartGame() {
        self.questionIndex = 0
        self.currentSeconds = 0
        self.mistakeAmount = 0
        self.gameResult = nil
        self.rightAnswer = nil
        self.wrongAnswers = []
    }

    private func endGame() {
        gameResult = GameResult(
                test: test,
                questionsAnswered: questionIndex,
                timeConsumed: currentSeconds,
                mistakesMade: mistakeAmount
        )
    }

    private func nextQuestion() {
        self.rightAnswer = nil
        self.wrongAnswers = []
        self.questionIndex += 1
    }
}
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

    @Published
    private var game: Game? = nil
    @Published
    private var questionIndex = 0

    var currentQuestion: Game.Question? {
        game?.questions[questionIndex]
    }

    init(gameId: String, repository: GameRepository) {
        self.repository = repository
        repository.getGame(gameId: gameId)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    print("getGame \(completion)")
                }, receiveValue: { output in
                    self.game = output
                })
                .store(in: &disposables)
    }

    func setAnswer(answer: Game.Answer) {
        if let game = self.game {
            if (questionIndex + 1 < game.questions.endIndex) {
                questionIndex += 1
            }
        }
    }

}
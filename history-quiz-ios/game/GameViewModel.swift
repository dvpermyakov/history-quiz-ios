//
//  GameViewModel.swift
//  history-quiz-ios
//
//  Created by Dmitrii Permiakov on 10/8/20.
//  Copyright © 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

class GameViewModel : ObservableObject {
    
    private var game: Game = Game(questions: [
        Game.Question(
            text: "In what year?",
            answers: [
                Game.Question.Answer(text: "862"),
                Game.Question.Answer(text: "902"),
                Game.Question.Answer(text: "942"),
                Game.Question.Answer(text: "304"),
            ]
        )
    ])
    private(set) var currentQuestion: Game.Question
    
    
    init() {
        currentQuestion = self.game.questions.first!
    }
}

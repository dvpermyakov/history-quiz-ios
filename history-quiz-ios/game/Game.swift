//
//  Game.swift
//  history-quiz-ios
//
//  Created by Dmitrii Permiakov on 10/8/20.
//  Copyright © 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct Game {
    var questions: Array<Question>

    struct Question {
        var text: String
        var answers: Array<Answer>
    }

    struct Answer {
        let id: String
        let text: String
        let correct: Bool
    }
}

//
//  Game.swift
//  history-quiz-ios
//
//  Created by Dmitrii Permiakov on 10/8/20.
//  Copyright © 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct Game {
    let questions: Array<Question>

    struct Question {
        let text: String
        let answers: Array<Answer>
    }

    struct Answer {
        let id: String
        let text: String
        let correct: Bool
    }
}

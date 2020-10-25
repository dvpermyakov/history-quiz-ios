//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

extension AnswerDto {
    func map() -> Game.Answer {
        Game.Answer(
                id: self.id,
                text: self.text,
                correct: self.correct
        )
    }
}

extension QuestionDto {
    func map() -> Game.Question {
        Game.Question(
                text: self.text,
                answers: self.answers.map { dto in
                    dto.map()
                }
        )
    }
}

extension GameDto {
    func map() -> Game {
        Game(questions: self.questions.map { dto in dto.map()})
    }
}
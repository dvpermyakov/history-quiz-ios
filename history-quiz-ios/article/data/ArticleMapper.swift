//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

extension ArticleDto {
    func map() -> Article {
        Article(
                text: self.text.map(),
                test: self.test.map(),
                persons: self.persons.map { dto in
                    dto.map()
                },
                events: self.events.map { dto in
                    dto.map()
                }
        )
    }
}

extension ArticleTextDto {
    func map() -> ArticleText {
        ArticleText(paragraphs: self.paragraphs.map { dto in
            dto.map()
        })
    }
}

extension ParagraphDto {
    func map() -> Paragraph {
        Paragraph(title: self.header, text: self.text, image: self.image)
    }
}

extension TestDto {
    func map() -> Test {
        Test(
                id: self.id,
                questionAmount: self.max_questions,
                mistakesAmount: self.max_mistakes,
                seconds: self.max_seconds
        )
    }
}
//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import CoreData

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

extension ArticleInfoDto {
    func map() -> ArticleInfo {
        ArticleInfo(
                id: self.id,
                category: self.category,
                name: self.name,
                description: self.description,
                image: self.image
        )
    }
}

extension ReadArticleEntity {
    func map() -> ReadArticle {
        ReadArticle(
                id: self.id!,
                articleId: self.articleId!,
                articleCategory: self.articleCategory!,
                date: self.date!
        )
    }
}

extension ReadArticle {
    func setEntity(for context: NSManagedObjectContext) {
        let entity = ReadArticleEntity(context: context)
        entity.id = self.id
        entity.articleId = self.articleId
        entity.articleCategory = self.articleCategory
        entity.date = self.date
    }
}

extension OpenedArticleEntity {
    func map() -> OpenedArticle {
        OpenedArticle(
                id: self.id!,
                articleId: self.articleId!,
                articleCategory: self.articleCategory!,
                date: self.date!
        )
    }
}

extension OpenedArticle {
    func setEntity(for context: NSManagedObjectContext) {
        let entity = OpenedArticleEntity(context: context)
        entity.id = self.id
        entity.articleId = self.articleId
        entity.articleCategory = self.articleCategory
        entity.date = self.date
    }
}
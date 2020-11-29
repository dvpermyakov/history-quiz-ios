//
// Created by Dmitrii Permiakov on 11/29/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import CoreData

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
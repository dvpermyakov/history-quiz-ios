//
// Created by Dmitrii Permiakov on 10/29/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct ArticleItemUiModel: ArticleAvailable {
    let id: String
    let category: String
    let image: String
    let title: String
    let subtitle: String
}

extension Person {
    func map() -> ArticleItemUiModel {
        ArticleItemUiModel(
                id: self.id,
                category: self.category,
                image: self.image,
                title: self.name,
                subtitle: self.description
        )
    }
}

extension Event {
    func map() -> ArticleItemUiModel {
        ArticleItemUiModel(
                id: self.id,
                category: self.category,
                image: self.image,
                title: self.name,
                subtitle: self.description
        )
    }
}
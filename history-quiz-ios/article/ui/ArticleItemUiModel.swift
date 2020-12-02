//
// Created by Dmitrii Permiakov on 10/29/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct ArticleItemUiModel: Identifiable, ArticleAvailable {
    let id: String
    let category: String
    let image: String
    let title: String
    let subtitle: String
    let additionalInfo: [AdditionalInfo]

    struct AdditionalInfo {
        let title: String
        let subtitle: String
    }
}

extension Person {
    func map() -> ArticleItemUiModel {
        ArticleItemUiModel(
                id: self.id,
                category: self.category,
                image: self.image,
                title: self.name,
                subtitle: self.yearTitle,
                additionalInfo: self.personTitles.map { personTitle in
                    ArticleItemUiModel.AdditionalInfo(
                            title: personTitle.name,
                            subtitle: personTitle.yearTitle
                    )
                }
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
                subtitle: self.yearTitle,
                additionalInfo: []
        )
    }
}
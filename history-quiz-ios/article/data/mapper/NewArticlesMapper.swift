//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

extension NewArticlesDto {
    func map() -> NewArticles {
        NewArticles(
                persons: self.persons.map { dto in
                    dto.map()
                },
                events: self.events.map { dto in
                    dto.map()
                }
        )
    }
}
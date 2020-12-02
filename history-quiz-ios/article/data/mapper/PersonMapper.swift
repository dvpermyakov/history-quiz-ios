//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

extension PersonDto {
    func map() -> Person {
        Person(
                id: self.id,
                category: self.category,
                name: self.name,
                description: self.description,
                image: self.image,
                yearTitle: self.year_title,
                personTitles: self.person_titles.map { personTitle in
                    personTitle.map()
                }
        )
    }
}

extension PersonTitleDto {
    func map() -> PersonTitle {
        PersonTitle(
                name: self.name,
                yearTitle: self.year_title
        )
    }
}
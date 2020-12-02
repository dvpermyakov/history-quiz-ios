//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

extension EventDto {
    func map() -> Event {
        Event(
                id: self.id,
                category: self.category,
                name: self.name,
                description: self.description,
                image: self.image,
                yearTitle: self.year_title
        )
    }
}
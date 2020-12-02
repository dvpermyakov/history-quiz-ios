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
                created: Date(timeIntervalSince1970: Double(self.created)!),
                name: self.name,
                description: self.description,
                image: self.image,
                yearTitle: self.year_title
        )
    }
}
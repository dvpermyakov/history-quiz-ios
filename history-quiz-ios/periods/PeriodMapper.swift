//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

extension PeriodDto {
    func map() -> Period {
        Period(
                id: self.id,
                image: self.image,
                name: self.name,
                description: self.year_title,
                developing: self.developing
        )
    }
}
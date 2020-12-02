//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

extension RatingDto {
    func map() -> [User] {
        self.users.map { userDto in
            userDto.map()
        }
    }
}
//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

extension UserDto {
    func map() -> User {
        User(
                id: self.id,
                name: self.name,
                image: self.image,
                testDone: self.test_done_amount
        )
    }
}
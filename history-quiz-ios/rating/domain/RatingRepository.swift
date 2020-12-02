//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Combine

protocol RatingRepository {
    func getUserRating() -> AnyPublisher<[User], Error>
}

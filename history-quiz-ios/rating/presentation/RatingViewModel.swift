//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

class RatingViewModel: ObservableObject {
    private let ratingRepository: RatingRepository
    private var disposables = Set<AnyCancellable>()

    @Published
    private(set) var users = [User]()
    @Published
    private(set) var error: String? = nil

    init(ratingRepository: RatingRepository) {
        self.ratingRepository = ratingRepository
        ratingRepository.getUserRating()
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(er) = completion {
                        self.error = er.localizedDescription
                    }
                }, receiveValue: { users in
                    self.users = users
                })
                .store(in: &disposables)
    }
}

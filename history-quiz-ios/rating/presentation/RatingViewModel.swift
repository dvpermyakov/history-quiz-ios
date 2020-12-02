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
    var users = [User]()
    @Published
    var error: String? = nil

    init(ratingRepository: RatingRepository) {
        self.ratingRepository = ratingRepository
        ratingRepository.getUserRating()
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        return
                    case .failure(let er):
                        self.error = er.localizedDescription
                    }
                }, receiveValue: { users in
                    self.users = users
                })
                .store(in: &disposables)
    }
}

//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

class PeriodsViewModel: ObservableObject {

    private let repository: PeriodsRepository
    private var disposables = Set<AnyCancellable>()

    @Published
    private(set) var periods: [Period] = []
    @Published
    private(set) var error: String? = nil

    init(repository: PeriodsRepository) {
        self.repository = repository

        repository.getPeriods()
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(er) = completion {
                        self.error = er.localizedDescription
                    }
                }, receiveValue: { output in
                    self.periods = output
                })
                .store(in: &disposables)
    }
}

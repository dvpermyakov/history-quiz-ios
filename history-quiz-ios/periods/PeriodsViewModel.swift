//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

class PeriodsViewModel: ObservableObject {

    private let repository = PeriodsRepository()
    private var disposables = Set<AnyCancellable>()

    @Published
    var periods: [Period] = []

    init() {
        repository.getPeriods()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    print(completion)
                }, receiveValue: { output in
                    print(output)
                    self.periods = output
                })
                .store(in: &disposables)
    }
}

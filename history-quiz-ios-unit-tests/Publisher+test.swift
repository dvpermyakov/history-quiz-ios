//
// Created by Dmitrii Permiakov on 11/28/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Combine
import XCTest

extension Published.Publisher where Output: Equatable {
    func assert(results expectedResults: [Output]) {
        var cancellable = Set<AnyCancellable>()
        var actualResults = [Output]()
        self.sink(receiveCompletion: { _ in
        }, receiveValue: { result in
            actualResults.append(result)
        }).store(in: &cancellable)
        XCTAssertEqual(expectedResults, actualResults)
    }
}

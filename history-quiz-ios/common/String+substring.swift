//
// Created by Dmitrii Permiakov on 11/30/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

extension String {

    func substring(_ leftIndex: Int, _ rightIndex: Int) -> String {
        String(self
                .dropFirst(leftIndex)
                .prefix(rightIndex - leftIndex)
        )
    }
}
//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

enum ArticlePart {
    case text
    case events
    case persons
    case test
}

extension ArticlePart {
    var name: String {
        switch self {
        case .text:
            return "Article".localized()
        case .events:
            return "Events".localized()
        case .persons:
            return "Persons".localized()
        case .test:
            return "Test".localized()
        }
    }
}

struct ArticleSelector: View {
    @Binding
    var selectedIndex: Int
    let selectors: [ArticlePart]

    var body: some View {
        Picker("selector", selection: $selectedIndex) {
            ForEach(0..<selectors.count) { index in
                Text(self.selectors[index].name).tag(index)
            }
        }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
    }
}
//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

enum ArticlePart {
    case Text
    case Events
    case Persons
    case Test
}

extension ArticlePart {
    var name: String {
        switch self {
        case .Text:
            return "Article".localized()
        case .Events:
            return "Events".localized()
        case .Persons:
            return "Persons".localized()
        case .Test:
            return "Test".localized()
        }
    }
}

struct ArticleSelector: View {
    @Binding
    var selectedIndex: Int
    var selectors: [ArticlePart]

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
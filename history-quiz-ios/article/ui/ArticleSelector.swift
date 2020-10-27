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
            return "Article"
        case .Events:
            return "Events"
        case .Persons:
            return "Persons"
        case .Test:
            return "Test"
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
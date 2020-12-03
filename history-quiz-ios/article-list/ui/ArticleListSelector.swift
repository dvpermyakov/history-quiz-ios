//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

enum ArticleListPart: Hashable {
    case opened
    case finished
    case new
}

extension ArticleListPart {
    var name: String {
        switch self {
        case .opened:
            return "Opened".localized()
        case .finished:
            return "Finished".localized()
        case .new:
            return "New".localized()
        }
    }
}

struct ArticleListSelector: View {
    var selectors: [ArticleListPart]
    @Binding
    var selected: ArticleListPart

    var body: some View {
        Picker(selection: $selected, label: Text("article list part")) {
            ForEach(selectors, id: \.self) { selector in
                Text(selector.name)
            }
        }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
    }
}

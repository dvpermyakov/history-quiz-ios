//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

enum ArticleListPart: Hashable {
    case Opened
    case Finished
    case New
}

extension ArticleListPart {
    var name: String {
        switch self {
        case .Opened:
            return "Opened".localized()
        case .Finished:
            return "Finished".localized()
        case .New:
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

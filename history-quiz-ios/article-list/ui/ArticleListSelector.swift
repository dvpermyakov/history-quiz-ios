//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

enum ArticleListPart {
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
    var selectedIndex: Int

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

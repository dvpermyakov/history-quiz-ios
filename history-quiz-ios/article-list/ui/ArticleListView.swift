//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct ArticleListView: View {
    private var selectors: [ArticleListPart]
    @State
    private var selectedIndex: Int = 0

    @ObservedObject
    var viewModel: ArticleListViewModel

    init(viewModel: ArticleListViewModel) {
        self.viewModel = viewModel
        self.selectors = [.Opened, .Finished, .New]
    }

    var body: some View {
        NavigationView {
            ScrollView {
                ArticleListSelector(
                        selectors: selectors,
                        selectedIndex: $selectedIndex
                )
                Group {
                    switch selectors[selectedIndex] {
                    case .Opened:
                        LoadedArticles(items: nil)
                    case .Finished:
                        LoadedArticles(items: nil)
                    case .New:
                        LoadedArticles(items: viewModel.newArticles?.getUiModels())
                    }

                }
            }.navigationBarTitle("Articles")
        }
    }
}

struct LoadedArticles: View {
    var items: [ArticleItemUiModel]?

    var body: some View {
        if let items = self.items {
            VStack(alignment: .leading) {
                ForEach(items) { item in
                    ArticleItemView(item: item)
                }
            }
        } else {
            ProgressView()
        }
    }
}

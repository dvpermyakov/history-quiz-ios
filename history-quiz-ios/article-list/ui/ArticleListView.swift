//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct ArticleListView: View {
    private var selectors: [ArticleListPart]
    @State
    private var selected: ArticleListPart = .opened

    @ObservedObject
    var viewModel: ArticleListViewModel

    init(viewModel: ArticleListViewModel) {
        self.viewModel = viewModel
        self.selectors = [.opened, .finished, .new]
    }

    var body: some View {
        NavigationView {
            ScrollView {
                ArticleListSelector(
                        selectors: selectors,
                        selected: $selected
                )
                Group {
                    switch selected {
                    case .opened:
                        LoadedArticles(items: nil)
                    case .finished:
                        LoadedArticles(items: nil)
                    case .new:
                        LoadedArticles(items: viewModel.newArticles?.getUiModels())
                    }

                }
            }.navigationBarTitle("Articles")
        }
    }
}

struct LoadedArticlesUiModel {
    let date: Date
    let articles: [ArticleItemUiModel]
}

struct LoadedArticles: View {
    var items: [LoadedArticlesUiModel]?

    var body: some View {
        if let items = self.items {
            VStack(alignment: .leading) {
                ForEach(0..<items.count) { itemIndex in
                    Text(items[itemIndex].date, style: .date)
                            .font(.system(size: 22))
                            .bold()
                            .padding(.horizontal)
                            .padding(.top)
                    ForEach(items[itemIndex].articles) { article in
                        VStack {
                            ArticleItemView(item: article)
                                    .padding(.horizontal)
                                    .padding(.bottom, 10)
                        }
                    }
                }
            }
        } else {
            Group {
                ProgressView()
            }.padding(.top, 30)
        }
    }
}

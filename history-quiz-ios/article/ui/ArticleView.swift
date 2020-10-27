//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct ArticleView: View {
    @ObservedObject
    var viewModel: ArticleViewModel

    var body: some View {
        Group {
            if let article = viewModel.article {
                LoadedArticleView(article: article)
            } else {
                ProgressView()
            }
        }
    }

}

struct LoadedArticleView: View {
    private var selectors: [ArticlePart]
    @State
    private var selectedIndex: Int = 0

    var article: Article

    init(article: Article) {
        selectors = [.Text]
        if (!article.events.isEmpty) {
            selectors.append(.Events)
        }
        if (!article.persons.isEmpty) {
            selectors.append(.Persons)
        }
        selectors.append(.Test)
        self.article = article
    }

    var body: some View {
        ScrollView {
            VStack {
                ArticleSelector(selectedIndex: $selectedIndex, selectors: selectors)
                Group {
                    switch selectors[selectedIndex] {
                    case .Text:
                        ParagraphsView(text: article.text)
                    case .Events:
                        EventsView(events: article.events)
                    case .Persons:
                        PersonsView(persons: article.persons)
                    case .Test:
                        Text("Test")
                    }
                }
            }
        }
    }
}
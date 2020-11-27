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
            if let article = viewModel.article, let testInfo = viewModel.testInfo {
                LoadedArticleView(article: article, testInfo: testInfo)
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
    @State
    private var showRules: Bool = false

    var article: Article
    var testInfo: CommonListUiModel


    init(article: Article, testInfo: CommonListUiModel) {
        selectors = [.Text]
        if (!article.events.isEmpty) {
            selectors.append(.Events)
        }
        if (!article.persons.isEmpty) {
            selectors.append(.Persons)
        }
        selectors.append(.Test)
        self.article = article
        self.testInfo = testInfo
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
                        VStack(alignment: .leading) {
                            ForEach(article.events) { event in
                                ArticleItemView(item: event.map())
                            }
                        }
                    case .Persons:
                        VStack(alignment: .leading) {
                            ForEach(article.persons) { person in
                                ArticleItemView(item: person.map())
                            }
                        }
                    case .Test:
                        ArticleTestView(
                                test: article.test,
                                testInfo: testInfo,
                                showRules: $showRules
                        )
                    }
                }
            }
        }
                .sheet(isPresented: $showRules) {
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Rules").font(Font.system(size: 24)).padding(.bottom, 10)
                            Text("Rules information".localized())
                        }.padding()
                    }
                }
    }
}
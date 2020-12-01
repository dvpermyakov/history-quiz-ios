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
                LoadedArticleView(
                        article: article,
                        testInfo: testInfo,
                        haveRead: viewModel.haveRead,
                        onReadClick: viewModel.onReadClick,
                        onLinkTap: viewModel.onLinkClick
                )
            } else if let error = viewModel.error {
                Text(error)
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
    @State
    private var moveToTest: Bool = false

    let article: Article
    let testInfo: CommonListUiModel
    let haveRead: Bool
    let onReadClick: () -> Void
    let onLinkTap: (String, String) -> Void

    init(
            article: Article,
            testInfo: CommonListUiModel,
            haveRead: Bool,
            onReadClick: @escaping () -> Void,
            onLinkTap: @escaping (String, String) -> Void
    ) {
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
        self.haveRead = haveRead
        self.onReadClick = onReadClick
        self.onLinkTap = onLinkTap
    }

    var body: some View {
        ScrollView {
            VStack {
                ArticleSelector(selectedIndex: $selectedIndex, selectors: selectors)
                Group {
                    switch selectors[selectedIndex] {
                    case .Text:
                        ParagraphsView(
                                text: article.text,
                                haveRead: haveRead,
                                onReadClick: onReadClick,
                                moveToTestInfo: {
                                    if let testIndex = selectors.firstIndex(of: .Test) {
                                        self.selectedIndex = testIndex
                                    }
                                },
                                startTest: {
                                    if let testIndex = selectors.firstIndex(of: .Test) {
                                        self.selectedIndex = testIndex
                                    }
                                    self.moveToTest = true
                                },
                                onLinkTap: onLinkTap
                        )
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
                                showRules: $showRules,
                                moveToTest: $moveToTest
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
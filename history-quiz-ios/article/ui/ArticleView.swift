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
                        openArticleClarification: $viewModel.openArticleClarification,
                        articleClarification: viewModel.articleClarification,
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
    let articleClarification: ArticleClarificationUiModel?
    let testInfo: CommonListUiModel
    let haveRead: Bool
    let onReadClick: () -> Void
    let onLinkTap: (String, String) -> Void

    @Binding
    var openArticleClarification: Bool

    init(
            article: Article,
            openArticleClarification: Binding<Bool>,
            articleClarification: ArticleClarificationUiModel?,
            testInfo: CommonListUiModel,
            haveRead: Bool,
            onReadClick: @escaping () -> Void,
            onLinkTap: @escaping (String, String) -> Void
    ) {
        selectors = [.Text]
        if (!article.persons.isEmpty) {
            selectors.append(.Persons)
        }
        if (!article.events.isEmpty) {
            selectors.append(.Events)
        }
        selectors.append(.Test)
        self.article = article
        self._openArticleClarification = openArticleClarification
        self.articleClarification = articleClarification
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
                                onLinkTap: { articleId, articleCategory in
                                    onLinkTap(articleId, articleCategory)
                                }
                        ).sheet(isPresented: $openArticleClarification) {
                            ArticleClarificationView(
                                    articleClarification: articleClarification,
                                    onBack: {
                                        openArticleClarification = false
                                    }
                            )
                        }
                    case .Events:
                        VStack(alignment: .leading) {
                            ForEach(article.events) { event in
                                ArticleItemView(item: event.map())
                                        .padding(.horizontal)
                                        .padding(.top, 10)
                            }
                        }
                    case .Persons:
                        VStack(alignment: .leading) {
                            ForEach(article.persons) { person in
                                ArticleItemView(item: person.map())
                                        .padding(.horizontal)
                                        .padding(.top, 10)
                            }
                        }
                    case .Test:
                        ArticleTestView(
                                test: article.test,
                                testInfo: testInfo,
                                showRules: $showRules,
                                moveToTest: $moveToTest
                        ).sheet(isPresented: $showRules) {
                            TestRulesView(onBack: {
                                showRules = false
                            })
                        }
                    }
                }
            }
        }
    }
}
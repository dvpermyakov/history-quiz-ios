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
        selectors = [.Text, .Test]
        if (!article.events.isEmpty) {
            selectors.insert(.Events, at: 1)
        }
        if (!article.persons.isEmpty) {
            selectors.insert(.Persons, at: 2)
        }
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

struct ParagraphsView: View {
    var text: ArticleText

    var body: some View {
        VStack {
            ForEach(text.paragraphs) { paragraph in
                VStack(alignment: .leading) {
                    Text(paragraph.title).font(Font.system(.body)).bold()
                    Group {
                        if let url = paragraph.image {
                            UrlImageView(url: url)
                        }
                    }
                    Text(paragraph.text).font(Font.system(.body))
                }.padding()
            }
        }
    }
}

struct PersonsView: View {
    var persons: [Person]

    var body: some View {
        VStack {
            ForEach(persons) { person in
                NavigationLink(destination: Router.createArticle(for: person)
                        .navigationBarTitle(person.name)
                ) {
                    Text(person.name)
                }
            }
        }
    }
}

struct EventsView: View {
    var events: [Event]

    var body: some View {
        VStack {
            ForEach(events) { event in
                NavigationLink(destination: Router.createArticle(for: event)
                        .navigationBarTitle(event.name)
                ) {
                    Text(event.name)
                }
            }
        }
    }
}

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
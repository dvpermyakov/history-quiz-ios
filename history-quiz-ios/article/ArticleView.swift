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
    var article: Article

    var body: some View {
        ScrollView {
            VStack {
                ForEach(article.text.paragraphs) { paragraph in
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
}
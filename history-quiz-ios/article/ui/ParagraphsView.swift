//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

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

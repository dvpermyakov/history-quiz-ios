//
// Created by Dmitrii Permiakov on 12/1/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct ArticleClarificationView: View {
    let article: ArticleDescription?

    var body: some View {
        ScrollView {
            if let article = self.article {
                VStack {
                    Text(article.name)
                    Text(article.description)
                }
            } else {
                ProgressView()
            }
        }
    }
}

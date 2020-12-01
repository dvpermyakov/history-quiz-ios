//
// Created by Dmitrii Permiakov on 12/1/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ArticleClarificationView: View {
    let article: ArticleDescription?
    let onBack: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: onBack) {
                NavigationBackView()
            }
            ScrollView {
                if let article = self.article {
                    VStack(alignment: .leading) {
                        Text(article.name)
                                .font(Font.system(size: 20))
                                .bold()
                        KFImage(URL(string: article.image))
                                .placeholder {
                                    ProgressView()
                                }
                                .resizable()
                                .scaledToFit()
                        Text(article.description)
                    }.padding(.top, 20)
                } else {
                    ProgressView()
                }
            }
        }.padding()
    }
}

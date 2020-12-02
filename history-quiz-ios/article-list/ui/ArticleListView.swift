//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct ArticleListView: View {
    @ObservedObject
    var viewModel: ArticleListViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                ArticleListSelector(
                        selectors: [
                            ArticleListPart.Opened,
                            ArticleListPart.Finished,
                            ArticleListPart.New
                        ]
                )
            }.navigationBarTitle("Articles")
        }
    }
}

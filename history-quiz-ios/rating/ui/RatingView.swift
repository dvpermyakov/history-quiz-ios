//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    @ObservedObject
    var viewModel: RatingViewModel

    var body: some View {
        NavigationView {
            Group {
                if let error = viewModel.error {
                    Text(error)
                } else if (viewModel.users.isEmpty) {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack {
                            ForEach(viewModel.users) { user in
                                Text(user.name)
                            }
                        }
                    }
                }
            }.navigationBarTitle("Rating")
        }
    }
}

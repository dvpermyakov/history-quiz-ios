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
                        VStack(alignment: .leading) {
                            ForEach(0..<viewModel.users.count) { userIndex in
                                Text(String(format: "Place with parameter".localized(), String(userIndex + 1)))
                                        .bold()
                                        .font(.system(size: 19))
                                        .padding(.horizontal, 22)
                                        .padding(.vertical, 2)
                                UserView(user: viewModel.users[userIndex])
                            }
                        }.padding(.bottom, 30)
                    }
                }
            }.navigationBarTitle("Rating")
        }
    }
}

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
                Text("Rating")
            }.navigationBarTitle("Rating")
        }
//        ForEach(viewModel.users) { user in
//            Text(user.name)
//        }
    }
}

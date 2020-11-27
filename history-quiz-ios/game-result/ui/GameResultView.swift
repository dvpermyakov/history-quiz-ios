//
// Created by Dmitrii Permiakov on 11/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct GameResultView: View {
    @ObservedObject
    var viewModel: GameResultViewModel

    var body: some View {
        VStack {
            Text("Result").padding(.bottom, 10)
            CommonListView(model: viewModel.resultInfo)
        }.padding()
    }
}

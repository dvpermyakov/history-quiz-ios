//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct PeriodsView: View {
    @ObservedObject
    var viewModel: PeriodsViewModel

    var body: some View {
        if viewModel.periods.isEmpty {
            ProgressView()
        } else {
            LoadedPeriodsView(periods: viewModel.periods)
        }
    }
}

struct LoadedPeriodsView: View {
    var periods: [Period]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(periods) { period in
                        NavigationLink(destination: Router.createGame()) {
                            VStack {
                                UrlImageView(url: period.image)
                                Text(period.name).padding()
                            }.padding()
                        }
                    }
                }
            }.navigationBarTitle("Periods")
        }
    }
}

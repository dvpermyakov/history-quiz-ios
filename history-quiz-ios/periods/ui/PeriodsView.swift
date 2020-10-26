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
                        VStack {
                            UrlImageView(url: period.image).cornerRadius(20)
                            NavigationLink(destination: Router.createArticle(for: period)
                                    .navigationBarTitle(period.name)
                            ) {
                                HStack {
                                    Text(period.name).padding()
                                    Text(period.description).padding()
                                }
                            }
                        }.padding()
                    }
                }
            }.navigationBarTitle("Periods")
        }
    }
}
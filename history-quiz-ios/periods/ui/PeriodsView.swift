//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct PeriodsView: View {
    @ObservedObject
    var viewModel: PeriodsViewModel

    var body: some View {
        if let error = viewModel.error {
            Text(error)
        } else if viewModel.periods.isEmpty {
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
                        PeriodView(period: period)
                    }
                }
            }.navigationBarTitle("Periods")
        }
    }
}

struct PeriodView: View {
    @State
    private var showProfile: Bool = false

    let period: Period

    init(period: Period) {
        self.period = period
    }

    var body: some View {
        Group {
            VStack(alignment: .leading) {
                KFImage(URL(string: period.image))
                        .placeholder {
                            ProgressView()
                        }
                        .centerCropped()
                        .frame(maxWidth: .infinity)
                        .frame(height: 170)
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(period.name)
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                        Text(period.description)
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                    }.padding(.leading, 20).padding(.bottom, 10)

                    NavigationLink(destination: getRouter().createArticle(for: period)
                            .navigationBarTitle(period.name)
                    ) {
                        NavigationSeeView()
                                .padding(.trailing, 20)
                    }
                }
            }
                    .background(Color.white)
                    .asCard()
        }
                .padding()
                .navigationBarItems(
                        trailing: Image(systemName: "person.crop.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    self.showProfile = true
                                }
                ).sheet(isPresented: $showProfile) {
                    getRouter().createProfile(onBack: {
                        showProfile = false
                    })
                }
    }
}

struct PeriodsView_Previews: PreviewProvider {
    static var previews: some View {
        PeriodView(period: Period(
                id: "1",
                category: "1",
                image: "1",
                name: "Киевская Русь",
                description: "100 - 200гг",
                developing: false
        ))
    }
}

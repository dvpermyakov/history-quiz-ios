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
                        PeriodView(period: period)
                    }
                }
            }.navigationBarTitle("Periods")
        }
    }
}

struct PeriodView: View {
    let period: Period

    var body: some View {
        Group {
            VStack(alignment: .leading) {
                UrlImageView(url: period.image)
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(period.name)
                            .foregroundColor(.black)
                            .font(.system(size: 17))
                        Text(period.description)
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                    }.padding(.leading, 20).padding(.bottom, 10)

                    NavigationLink(destination: Router.createArticle(for: period)
                            .navigationBarTitle(period.name)
                    ) {
                        HStack {
                            Text("See")
                            Image(systemName: "chevron.right")
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .trailing
                        )
                        .padding(.trailing, 20)
                    }
                }
            }
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.gray, radius: 50)
        }.padding()
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

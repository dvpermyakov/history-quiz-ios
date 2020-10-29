//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject
    var viewModel: MainViewModel

    private var tabs: [MainTab]

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        tabs = [MainTab.Periods, MainTab.Balance]
    }

    var body: some View {
        TabView() {
            ForEach(tabs) { tab in
                MainTabContentView(tab: tab).tabItem {
                    Image(systemName: tab.image)
                    Text(tab.name)
                }
            }
        }.alert(isPresented: $viewModel.showDailyAwardAlert) {
            Alert(title: Text("Daily reward"), message: Text("You receive your new daily reward! Congrats!"))
        }
    }
}

struct MainTabContentView: View {
    var tab: MainTab

    var body: some View {
        Group {
            switch tab {
            case .Periods:
                Router.createPeriods()
            case .Balance:
                Router.createBalance()
            }
        }
    }

}

enum MainTab {
    case Periods
    case Balance
}

extension MainTab: Identifiable {
    var id: String {
        self.name
    }

    var name: String {
        switch self {
        case .Periods:
            return "Periods"
        case .Balance:
            return "Balance"
        }
    }
    var image: String {
        switch self {
        case .Periods:
            return "list.bullet"
        case .Balance:
            return "banknote.fill"
        }
    }
}
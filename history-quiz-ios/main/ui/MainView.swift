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
        }.alert(isPresented: $viewModel.showAwardAlert) {
            try! MoneyAlertFactory.createMoneyAlert(viewModel.awardInfo)
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
        switch self {
        case .Periods:
            return "periods_id"
        case .Balance:
            return "balance_id"
        }
    }

    var name: LocalizedStringKey {
        switch self {
        case .Periods:
            return LocalizedStringKey("Periods")
        case .Balance:
            return LocalizedStringKey("Balance")
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
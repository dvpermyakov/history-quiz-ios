//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct MainView: View {
    private var tabs = [MainTab.Periods, MainTab.Balance]

    var body: some View {
        TabView() {
            ForEach(tabs) { tab in
                MainTabContentView(tab: tab).tabItem {
                    Image(systemName: tab.image)
                    Text(tab.name)
                }
            }
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
            return "list.dash"
        case .Balance:
            return "square.and.pencil"
        }
    }
}
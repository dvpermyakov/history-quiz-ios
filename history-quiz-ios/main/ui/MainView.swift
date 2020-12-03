//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct MainView: View {
    private var tabs: [MainTab]

    @ObservedObject
    var viewModel: MainViewModel

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        tabs = [.periods, .balance, .articles, .rating]
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
    @EnvironmentObject
    var router: Router

    var tab: MainTab

    var body: some View {
        Group {
            switch tab {
            case .periods:
                router.createPeriods()
            case .balance:
                router.createBalance()
            case .articles:
                router.createArticleList()
            case .rating:
                router.createRating()
            }
        }
    }

}

enum MainTab {
    case periods
    case balance
    case articles
    case rating
}

extension MainTab: Identifiable {
    var id: String {
        switch self {
        case .periods:
            return "periods_id"
        case .balance:
            return "balance_id"
        case .articles:
            return "articles_id"
        case .rating:
            return "rating_id"
        }
    }
    var name: LocalizedStringKey {
        switch self {
        case .periods:
            return LocalizedStringKey("Periods")
        case .balance:
            return LocalizedStringKey("Balance")
        case .articles:
            return LocalizedStringKey("Articles")
        case .rating:
            return LocalizedStringKey("Rating")
        }
    }
    var image: String {
        switch self {
        case .periods:
            return "list.bullet"
        case .balance:
            return "banknote.fill"
        case .articles:
            return "doc.plaintext"
        case .rating:
            return "person.3.fill"
        }
    }
}
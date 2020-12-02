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
        tabs = [.Periods, .Balance, .Articles, .Rating]
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
                getRouter().createPeriods()
            case .Balance:
                getRouter().createBalance()
            case .Articles:
                getRouter().createArticleList()
            case .Rating:
                getRouter().createRating()
            }
        }
    }

}

enum MainTab {
    case Periods
    case Balance
    case Articles
    case Rating
}

extension MainTab: Identifiable {
    var id: String {
        switch self {
        case .Periods:
            return "periods_id"
        case .Balance:
            return "balance_id"
        case .Articles:
            return "articles_id"
        case .Rating:
            return "rating_id"
        }
    }
    var name: LocalizedStringKey {
        switch self {
        case .Periods:
            return LocalizedStringKey("Periods")
        case .Balance:
            return LocalizedStringKey("Balance")
        case .Articles:
            return LocalizedStringKey("Articles")
        case .Rating:
            return LocalizedStringKey("Rating")
        }
    }
    var image: String {
        switch self {
        case .Periods:
            return "list.bullet"
        case .Balance:
            return "banknote.fill"
        case .Articles:
            return "doc.plaintext"
        case .Rating:
            return "person.3.fill"
        }
    }
}
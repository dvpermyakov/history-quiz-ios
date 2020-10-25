//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

class Router {
    static func createPeriods() -> PeriodsView {
        PeriodsView(viewModel: PeriodsViewModel())
    }

    static func createBalance() -> BalanceView {
        BalanceView()
    }

    static func createGame() -> GameView {
        GameView(viewModel: GameViewModel(gameId: "4747716777213952"))
    }

    static func createArticle(for item: ArticleAvailable) -> ArticleView {
        ArticleView(viewModel: ArticleViewModel(id: item.id, category: item.category))
    }
}

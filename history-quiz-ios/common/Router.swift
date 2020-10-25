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

    static func createArticle(id: String, category: String) -> ArticleView {
        ArticleView(viewModel: ArticleViewModel(id: id, category: category))
    }
}

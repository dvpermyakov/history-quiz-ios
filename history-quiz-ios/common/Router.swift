//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

class Router: ObservableObject {
    let balanceRepository: BalanceRepository
    let periodsRepository: PeriodsRepository
    let gameRepository: GameRepository
    let articleRepository: ArticleRepository

    init(
            balanceRepository: BalanceRepository,
            periodsRepository: PeriodsRepository,
            gameRepository: GameRepository,
            articleRepository: ArticleRepository
    ) {
        self.balanceRepository = balanceRepository
        self.periodsRepository = periodsRepository
        self.gameRepository = gameRepository
        self.articleRepository = articleRepository
    }

    func createMain() -> MainView {
        MainView(viewModel: MainViewModel(
                repository: balanceRepository
        ))
    }

    func createPeriods() -> PeriodsView {
        PeriodsView(viewModel: PeriodsViewModel(
                repository: periodsRepository
        ))
    }

    func createBalance() -> BalanceView {
        BalanceView(viewModel: BalanceViewModel(
                repository: balanceRepository
        ))
    }

    func createTest(test: Test) -> GameView {
        GameView(viewModel: GameViewModel(
                test: test,
                repository: gameRepository
        ))
    }

    func createArticle(for item: ArticleAvailable) -> ArticleView {
        ArticleView(viewModel: ArticleViewModel(
                id: item.id,
                category: item.category,
                articleRepository: articleRepository,
                balanceRepository: balanceRepository
        ))
    }
}

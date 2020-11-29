//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

class Router {
    private static let balanceRepository: BalanceRepository = BalanceRepositoryImpl()
    private static let periodsRepository: PeriodsRepository = PeriodsRepositoryIml()
    private static let gameRepository: GameRepository = GameRepositoryIml()
    private static let articleRepository: ArticleRepository = ArticleRepositoryIml()

    static func createMain() -> MainView {
        MainView(viewModel: MainViewModel(
                repository: balanceRepository
        ))
    }

    static func createPeriods() -> PeriodsView {
        PeriodsView(viewModel: PeriodsViewModel(
                repository: periodsRepository
        ))
    }

    static func createBalance() -> BalanceView {
        BalanceView(viewModel: BalanceViewModel(
                repository: balanceRepository
        ))
    }

    static func createTest(test: Test) -> GameView {
        GameView(viewModel: GameViewModel(
                test: test,
                repository: gameRepository
        ))
    }

    static func createArticle(for item: ArticleAvailable) -> ArticleView {
        ArticleView(viewModel: ArticleViewModel(
                id: item.id,
                category: item.category,
                articleRepository: articleRepository,
                balanceRepository: balanceRepository
        ))
    }
}

//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

class Router {

    static func createMain() -> MainView {
        let balanceRepository: BalanceRepository = BalanceRepositoryImpl()
        return MainView(viewModel: MainViewModel(
                repository: balanceRepository
        ))
    }

    static func createPeriods() -> PeriodsView {
        let periodsRepository: PeriodsRepository = PeriodsRepositoryIml()
        return PeriodsView(viewModel: PeriodsViewModel(
                repository: periodsRepository
        ))
    }

    static func createBalance() -> BalanceView {
        let balanceRepository: BalanceRepository = BalanceRepositoryImpl()
        return BalanceView(viewModel: BalanceViewModel(
                repository: balanceRepository
        ))
    }

    static func createTest(test: Test) -> GameView {
        let gameRepository: GameRepository = GameRepositoryIml()
        return GameView(viewModel: GameViewModel(
                test: test,
                repository: gameRepository
        ))
    }

    static func createTestResult(result: GameResult) -> GameResultView {
        GameResultView(viewModel: GameResultViewModel(
                result: result
        ))
    }

    static func createArticle(for item: ArticleAvailable) -> ArticleView {
        let articleRepository: ArticleRepository = ArticleRepositoryIml()
        return ArticleView(viewModel: ArticleViewModel(
                id: item.id,
                category: item.category,
                repository: articleRepository
        ))
    }
}

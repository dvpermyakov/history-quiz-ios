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
    let ratingRepository: RatingRepository

    init(
            balanceRepository: BalanceRepository,
            periodsRepository: PeriodsRepository,
            gameRepository: GameRepository,
            articleRepository: ArticleRepository,
            ratingRepository: RatingRepository
    ) {
        self.balanceRepository = balanceRepository
        self.periodsRepository = periodsRepository
        self.gameRepository = gameRepository
        self.articleRepository = articleRepository
        self.ratingRepository = ratingRepository
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

    func createArticleList() -> ArticleListView {
        ArticleListView(viewModel: ArticleListViewModel(
                articleRepository: articleRepository
        ))
    }

    func createProfile(onBack: @escaping () -> Void) -> ProfileView {
        ProfileView(onBack: onBack)
    }

    func createRating() -> RatingView {
        RatingView(viewModel: RatingViewModel(
                ratingRepository: ratingRepository
        ))
    }
}

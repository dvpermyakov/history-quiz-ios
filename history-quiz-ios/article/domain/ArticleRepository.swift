//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

protocol ArticleRepository {
    func getArticle(id: String, category: String) -> AnyPublisher<Article, Error>
}

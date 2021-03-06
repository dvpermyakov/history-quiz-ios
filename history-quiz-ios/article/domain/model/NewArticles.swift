//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct NewArticles {
    let persons: [Person]
    let events: [Event]
}

extension NewArticles {
    func getUiModels() -> [LoadedArticlesUiModel] {
        (self.persons.map { person in
            person.map()
        } + self.events.map { event in
            event.map()
        }).sorted {
            $0.created > $1.created
        }.map { item in
            LoadedArticlesUiModel(date: item.created, articles: [item])
        }
    }
}
//
// Created by Dmitrii Permiakov on 11/29/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import CoreData

func getBalanceContext() -> NSManagedObjectContext? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return nil
    }
    return appDelegate.balancePersistentContainer.viewContext
}

func getArticleContext() -> NSManagedObjectContext? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return nil
    }
    return appDelegate.articlePersistentContainer.viewContext
}
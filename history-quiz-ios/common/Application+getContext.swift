//
// Created by Dmitrii Permiakov on 11/29/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import CoreData

func getContext() -> NSManagedObjectContext? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return nil
    }
    return appDelegate.persistentContainer.viewContext
}
//
// Created by Dmitrii Permiakov on 12/1/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

func getRouter() -> Router {
    (UIApplication.shared.delegate as! AppDelegate).router
}

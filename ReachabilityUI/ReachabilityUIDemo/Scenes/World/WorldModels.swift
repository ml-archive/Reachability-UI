//
//  WorldModels.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import ReachabilityUI

enum World {
    struct ReachabilityListener {}
}

extension World.ReachabilityListener {
    struct Request {}
    struct Response {
        let reachabilityNotification: ReachabilityNotificationType
    }
    struct Display {
        let reachabilityNotification: ReachabilityNotificationType
    }
}

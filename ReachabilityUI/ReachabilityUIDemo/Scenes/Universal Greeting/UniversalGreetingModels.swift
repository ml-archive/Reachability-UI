//
//  UniversalGreetingModels.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 05/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation

enum UniversalGreeting {
    struct ReachabilityListener {}
}

extension UniversalGreeting.ReachabilityListener {
    struct Request {}
    struct Response {
        let isConnected: Bool
    }
    struct Display {
        let isConnected: Bool
    }
}

//
//  Dependencies.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//


import Foundation
import ReachabilityUI

typealias FullDependencies =
    HasReachabilityListenerRepository

struct Dependencies {
    public static let shared = Dependencies()
    public var reachabilityListenerFactoryProtocol: ReachabilityListenerFactoryProtocol
    
    init() {
        reachabilityListenerFactoryProtocol = ReachabilityUIManager()
    }
    
}

extension Dependencies: HasReachabilityListenerRepository {
}

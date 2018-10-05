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
    HasReachabilityUIRepository

struct Dependencies {
    public static let shared = Dependencies()
    
    public var reachabilityUIEmbedableRepository: ReachabilityUIRepository
    
    init() {
        let reachabilityUIManager = ReachabilityUIManager()
        reachabilityUIRepository = reachabilityUIManager
    }
    
}

extension Dependencies: HasReachabilityUIRepository {

}

//
//  Dependencies.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//


import Foundation

typealias FullDependencies =
    HasReachabilityUIRepository & HasReachabilityRepository

struct Dependencies {
    public static let shared = Dependencies()
    
    public var reachabilityRepository: ReachabilityRepository
    public var reachabilityUIEmbedableRepository: ReachabilityUIEmbedableRepository
    public var reachabilityUIControlRepository: ReachabilityUIControlRepository
    
    init() {
        let reachabilityUIManager = ReachabilityUIManager()
        reachabilityUIEmbedableRepository = reachabilityUIManager
        reachabilityUIControlRepository = reachabilityUIManager
        reachabilityRepository = ReachabilityManager()
        reachabilityRepository.setup(reachabilityUIManager)
    }
    
}

extension Dependencies: HasReachabilityUIRepository, HasReachabilityRepository {

}

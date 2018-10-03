//
//  WorldInteractor.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation

class WorldInteractor {
    // MARK: - Properties
    
    weak var output: WorldInteractorOutput?
    private var reachabilityUIEmbedableRepository: ReachabilityUIEmbedableRepository
    
    // MARK: - Init
    
    init(reachabilityUIEmbedableRepository: ReachabilityUIEmbedableRepository) {
        self.reachabilityUIEmbedableRepository = reachabilityUIEmbedableRepository
    }
    
    deinit {
        reachabilityUIEmbedableRepository.removeListener(for: "\(WorldInteractor.self)")
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension WorldInteractor: WorldInteractorInput {
}

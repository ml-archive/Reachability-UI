//
//  ReachabilityInteractor.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 04/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation

class ReachabilityInteractor {
    // MARK: - Properties
    
    weak var output: ReachabilityInteractorOutput?
    private var reachabilityUIEmbedableRepository: ReachabilityUIEmbedableRepository
    
    // MARK: - Init
    
    init(reachabilityUIEmbedableRepository: ReachabilityUIEmbedableRepository) {
        self.reachabilityUIEmbedableRepository = reachabilityUIEmbedableRepository
    }
    
    deinit {
        reachabilityUIEmbedableRepository.removeListener(for: "\(ReachabilityInteractor.self)")
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension ReachabilityInteractor: ReachabilityInteractorInput {
    func perform(_ request:  Reachability.ReachabilityListener.Request) {
        let listener: ReachabilityListener = { [weak self] isConnected in
            self?.output?.present(Reachability.ReachabilityListener.Response(isConnected: isConnected))
        }
        reachabilityUIEmbedableRepository.addListener(listener: listener, for: "\(ReachabilityInteractor.self)")
    }
    
}

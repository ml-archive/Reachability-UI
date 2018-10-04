//
//  HelloInteractor.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import ReachabilityUI

class HelloInteractor {
    
    // MARK: - Properties
    
    weak var output: HelloInteractorOutput?
    private var reachabilityUIEmbedableRepository: ReachabilityUIEmbedableRepository

    // MARK: - Init
    
    init(reachabilityUIEmbedableRepository: ReachabilityUIEmbedableRepository) {
        self.reachabilityUIEmbedableRepository = reachabilityUIEmbedableRepository
    }
    
    deinit {
        reachabilityUIEmbedableRepository.removeListener(for: "\(HelloInteractor.self)")
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension HelloInteractor: HelloInteractorInput {
    func perform(_ request: Hello.ReachabilityListener.Request) {
        let listener: ReachabilityListener = { [weak self] isConnected in
            self?.output?.present(Hello.ReachabilityListener.Response(isConnected: isConnected))
        }
        reachabilityUIEmbedableRepository.addListener(listener: listener, for: "\(HelloInteractor.self)")
    }
    
}

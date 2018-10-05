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
    private var reachabilityListenerFactory: ReachabilityListenerFactoryProtocol
    private var listener: ReachabilityListenerProtocol!

    // MARK: - Init
    
    init(reachabilityListenerFactory: ReachabilityListenerFactoryProtocol) {
        self.reachabilityListenerFactory = reachabilityListenerFactory
    }

}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension HelloInteractor: HelloInteractorInput {
    func perform(_ request: Hello.ReachabilityListener.Request) {
        let listener = reachabilityListenerFactory.makeListener()
        self.listener = listener
        listener.listen { [weak self] (isConnected) in
            self?.output?.present(Hello.ReachabilityListener.Response(isConnected: isConnected))
        }
    }
    
}

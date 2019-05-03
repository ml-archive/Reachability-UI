//
//  UniversalGreetingInteractor.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 05/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import ReachabilityUI

class UniversalGreetingInteractor {
    // MARK: - Properties
    weak var output: UniversalGreetingInteractorOutput?
    private var reachabilityListenerFactory: ReachabilityListenerFactoryProtocol
    private var listener: ReachabilityListenerProtocol!
    // MARK: - Init
    
    init(reachabilityListenerFactory: ReachabilityListenerFactoryProtocol) {
        self.reachabilityListenerFactory = reachabilityListenerFactory
    }
    
    deinit {
        print("deinit gets called")
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension UniversalGreetingInteractor: UniversalGreetingInteractorInput {
    func perform(_ request: UniversalGreeting.ReachabilityListener.Request) {
        let listener = reachabilityListenerFactory.makeListener()
        self.listener = listener
        listener.listen { [weak self] (isConnected) in
            self?.output?.present(UniversalGreeting.ReachabilityListener.Response(isConnected: isConnected))
        }
    }
}

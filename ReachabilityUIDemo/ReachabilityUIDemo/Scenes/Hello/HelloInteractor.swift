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
    private var reachabilityListenerFactoryProtocol: ReachabilityListenerFactoryProtocol
    private var listener: ReachabilityListener!
    
    // MARK: - Init
    
    init(reachabilityListenerFactoryProtocol: ReachabilityListenerFactoryProtocol) {
        self.reachabilityListenerFactoryProtocol = reachabilityListenerFactoryProtocol
    }

}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension HelloInteractor: HelloInteractorInput {
    func perform(_ request: Hello.ReachabilityListener.Request) {
        let listener = reachabilityListenerFactoryProtocol.makeListener()
        listener.listen { [weak self] (isConnected) in
            self?.output?.present(Hello.ReachabilityListener.Response(isConnected: isConnected))
        }
    }
    
}

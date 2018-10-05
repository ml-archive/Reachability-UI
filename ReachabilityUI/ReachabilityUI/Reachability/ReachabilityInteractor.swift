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
    private var reachabilityListenerFactoryProtocol: ReachabilityListenerFactoryProtocol
    private var listener: ReachabilityListenerProtocol!
    
    
    // MARK: - Init
    
    init(reachabilityListenerFactoryProtocol: ReachabilityListenerFactoryProtocol) {
        self.reachabilityListenerFactoryProtocol = reachabilityListenerFactoryProtocol
    }
    
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension ReachabilityInteractor: ReachabilityInteractorInput {
    func perform(_ request:  Reachability.ReachabilityListener.Request) {
        let listener = reachabilityListenerFactoryProtocol.makeListener()
        self.listener = listener
        listener.listen { [weak self] isConnected in
            self?.output?.present(Reachability.ReachabilityListener.Response(isConnected: isConnected))
        }
    }
    
}

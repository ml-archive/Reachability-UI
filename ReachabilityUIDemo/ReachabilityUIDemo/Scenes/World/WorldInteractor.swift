//
//  WorldInteractor.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import ReachabilityUI

class WorldInteractor {
    // MARK: - Properties
    
    weak var output: WorldInteractorOutput?
    private var reachabilityListenerFactoryProtocol: ReachabilityListenerFactoryProtocol
    private var listener: ReachabilityListenerProtocol!
    // MARK: - Init
    
    init(reachabilityListenerFactoryProtocol: ReachabilityListenerFactoryProtocol) {
        self.reachabilityListenerFactoryProtocol = reachabilityListenerFactoryProtocol
    }

}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension WorldInteractor: WorldInteractorInput {
    func perform(_ request: World.ReachabilityListener.Request) {
        let listener = reachabilityListenerFactoryProtocol.makeListener()
        self.listener = listener
        listener.listen { [weak self] (isConnected) in
            self?.output?.present(World.ReachabilityListener.Response(isConnected: isConnected))
        }
    }
}

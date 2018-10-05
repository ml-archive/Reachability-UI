//
//  ReachabilityListener.swift
//  ReachabilityUI
//
//  Created by Andrei Hogea on 05/10/2018.
//  Copyright © 2018 Nodes Aps. All rights reserved.
//

import Foundation

public protocol ReachabilityListenerProtocol {
    func listen(_ closure: @escaping Listener)
}

public final class ReachabilityListener: ReachabilityListenerProtocol {
    
    private let ReachabilityListenerRepository: ReachabilityListenerRepository
    let id: Int
    
    init(ReachabilityListenerRepository: ReachabilityListenerRepository, id: Int) {
        self.ReachabilityListenerRepository = ReachabilityListenerRepository
        self.id = id
    }
    
    public func listen(_ closure: @escaping Listener) {
        ReachabilityListenerRepository.addListener(closure, id: id)
    }
    
    deinit {
        ReachabilityListenerRepository.removeListener(for: id)
    }
}

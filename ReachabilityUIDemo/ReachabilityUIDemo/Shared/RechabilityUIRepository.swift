//
//  ReachabilityUIRepository.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import Foundation

typealias ReachabilityListener = (_ isConnected: Bool) -> Void

protocol ReachabilityUIEmbedableRepository: class {
    func addListener(listener: @escaping ReachabilityListener, for id: String)
    func removeListener(for id: String)
}

protocol ReachabilityUIControlRepository: class {
    func networkStatusChanged(_ isConnected: Bool)
}

protocol HasReachabilityUIRepository {
    var reachabilityUIEmbedableRepository: ReachabilityUIEmbedableRepository { get set }
    var reachabilityUIControlRepository: ReachabilityUIControlRepository { get set }
}

final class ReachabilityUIManager: ReachabilityUIEmbedableRepository {
    public static let shared = ReachabilityUIManager()
    
    private var isConnected = false {
        didSet {
            notify()
        }
    }
    private var listeners: [String: ReachabilityListener] = [:]
    
    func addListener(listener: @escaping ReachabilityListener, for id: String) {
        listeners[id] = listener
        notify()
    }
    
    func removeListener(for id: String) {
        listeners[id] = nil
    }
    
    private func notify() {
        listeners.values.forEach { (listener) in
            listener(isConnected)
        }
    }
}

extension ReachabilityUIManager: ReachabilityUIControlRepository {
    func networkStatusChanged(_ isConnected: Bool) {
        self.isConnected = isConnected
    }
}

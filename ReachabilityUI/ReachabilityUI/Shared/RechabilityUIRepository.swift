//
//  ReachabilityListenerRepository.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import Foundation

public typealias Listener = (_ isConnected: Bool) -> Void

// MARK: - Public protocols

public protocol ReachabilityListenerFactoryProtocol: class {
    func makeListener() -> ReachabilityListenerProtocol
}

// MARK: - Internal protocols

protocol ReachabilityListenerRepository: class {
    func addListener(_ listener: @escaping Listener, id: Int)
    func removeListener(for id: Int)
}

protocol ReachabilityDelegate: class {
    func networkStatusChanged(_ isConnected: Bool)
}

public protocol HasReachabilityListenerRepository {
    var reachabilityListenerFactory: ReachabilityListenerFactoryProtocol { get set }
}

public final class ReachabilityUIManager: ReachabilityListenerRepository {
    public static let shared = ReachabilityUIManager()
    
    private var reachabilityManager: ReachabilityManager!
    private var listenerCount: Int = 0
    private var isConnected = false {
        didSet {
            notify()
        }
    }
    private var listeners: [Int: Listener] = [:]
    
    // MARK: - Init
    
    public init() {
        reachabilityManager = ReachabilityManager()
        reachabilityManager.setup(self)
    }
    
    // MARK: - Listeners
    
    func addListener(_ listener: @escaping Listener, id: Int) {
        listeners[id] = listener
        notify()
    }
    
    func removeListener(for id: Int) {
        listeners[id] = nil
    }
    
    private func notify() {
        listeners.values.forEach { (listener) in
            listener(isConnected)
        }
    }
}

// MARK: - ReachabilityDelegate

extension ReachabilityUIManager: ReachabilityListenerFactoryProtocol {
    public func makeListener() -> ReachabilityListenerProtocol {
        listenerCount += 1
        return ReachabilityListener(ReachabilityListenerRepository: self, id: listenerCount)
    }
}


// MARK: - ReachabilityDelegate

extension ReachabilityUIManager: ReachabilityDelegate {
    func networkStatusChanged(_ isConnected: Bool) {
        self.isConnected = isConnected
    }
}

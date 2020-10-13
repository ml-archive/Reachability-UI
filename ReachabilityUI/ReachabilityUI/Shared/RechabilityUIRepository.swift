//
//  ReachabilityListenerRepository.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import Foundation

public typealias Listener = (_ notification: ReachabilityNotificationType) -> Void

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
    func networkTypeChanged(_ isCellular: Bool)
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
            notify(.connectionChange(isConnected))
        }
    }
    private var isCellular = false {
        didSet {
            notify(.connectionTypeChange(isCellular))
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
        notify(.connectionChange(isConnected))
    }
    
    func removeListener(for id: Int) {
        listeners[id] = nil
    }
    
    private func notify(_ notification: ReachabilityNotificationType) {
        listeners.values.forEach { (listener) in
            listener(notification)
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
    
    func networkTypeChanged(_ isCellular: Bool) {
        if isCellular != self.isCellular {
            self.isCellular = isCellular
        }
    }
}

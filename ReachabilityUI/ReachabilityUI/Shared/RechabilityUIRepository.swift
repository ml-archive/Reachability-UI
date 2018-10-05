//
//  ReachabilityUIRepository.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import Foundation

public typealias ReachabilityListener = (_ isConnected: Bool) -> Void

public protocol ReachabilityUIRepository: class {
    func addListener(listener: @escaping ReachabilityListener, for id: String)
    func removeListener(for id: String)
}

protocol ReachabilityDelegate: class {
    func networkStatusChanged(_ isConnected: Bool)
}

public protocol HasReachabilityUIRepository {
    var reachabilityUIRepository: ReachabilityUIRepository { get set }
}

public final class ReachabilityUIManager: ReachabilityUIRepository {
    public static let shared = ReachabilityUIManager()
    
    private var isConnected = false {
        didSet {
            notify()
        }
    }
    private var listeners: [String: ReachabilityListener] = [:]
    
    // MARK: - Init
    
    public init() {
        let reachabilityManager = ReachabilityManager()
        reachabilityManager.setup(self)
    }
    
    // MARK: - Listeners
    
    public func addListener(listener: @escaping ReachabilityListener, for id: String) {
        listeners[id] = listener
        notify()
    }
    
    public func removeListener(for id: String) {
        listeners[id] = nil
    }
    
    private func notify() {
        listeners.values.forEach { (listener) in
            listener(isConnected)
        }
    }
}

// MARK: - ReachabilityDelegate

extension ReachabilityUIManager: ReachabilityDelegate {
    func networkStatusChanged(_ isConnected: Bool) {
        self.isConnected = isConnected
    }
}

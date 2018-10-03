//
//  ReachabilityRepository.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import Foundation
import SystemConfiguration

protocol ReachabilityRepository: class {
    func setup(_ reachabilityUIControlRepository: ReachabilityUIControlRepository)
}

protocol HasReachabilityRepository {
    var reachabilityRepository: ReachabilityRepository { get set }
}

final class ReachabilityManager: ReachabilityRepository {
    
    public static let shared = ReachabilityManager()
    
    private var reachabilityUIControlRepository: ReachabilityUIControlRepository?
    
    private var isConnected = false {
        didSet {
            guard reachabilityUIControlRepository != nil else { return }
            reachabilityUIControlRepository?.networkStatusChanged(isConnected)
        }
    }
    
    // MARK: - Reachability releated
    
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")
    // Queue where the `SCNetworkReachability` callbacks run
    private let queue = DispatchQueue.global(qos: .background)
    // We use it to keep a backup of the last flags read.
    private var currentReachabilityFlags: SCNetworkReachabilityFlags? {
        didSet {
            if let currentReachabilityFlags = currentReachabilityFlags {
                isConnected = currentReachabilityFlags.contains(.reachable)
            }
        }
    }
    // Flag used to avoid starting listening if we are already listening
    private var isListening = false
    
    // MARK: - Init
    
    init() {
        start()
    }
    
    deinit {
        stop()
    }
    
    // MARK: - Setup
    
    func setup(_ reachabilityUIControlRepository: ReachabilityUIControlRepository) {
        self.reachabilityUIControlRepository = reachabilityUIControlRepository
    }
    
    // MARK: - Reachability Logic
    
    // Starts listening
    private func start() {
        // Checks if we are already listening
        guard !isListening else { return }
        // Optional binding since `SCNetworkReachabilityCreateWithName` returns an optional object
        guard let reachability = reachability else { return }
        // Creates a context
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        // Sets `self` as listener object
        context.info = UnsafeMutableRawPointer(Unmanaged<ReachabilityManager>.passUnretained(self).toOpaque())
        let callbackClosure: SCNetworkReachabilityCallBack? = {
            (reachability:SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) in
            guard let info = info else { return }
            // Gets the `Handler` object from the context info
            let handler = Unmanaged<ReachabilityManager>.fromOpaque(info).takeUnretainedValue()
            DispatchQueue.main.async {
                handler.checkReachability(flags: flags)
            }
        }
        // Registers the callback. `callbackClosure` is the closure where we manage the callback implementation
        if !SCNetworkReachabilitySetCallback(reachability, callbackClosure, &context) {
            // Not able to set the callback
            print("lolololo2")
        }
        // Sets the dispatch queue which is `DispatchQueue.main` for this example. It can be also a background queue
        if !SCNetworkReachabilitySetDispatchQueue(reachability, queue) {
            // Not able to set the queue
            print("lolololo")
        }
        // Runs the first time to set the current flags
        queue.async {
            // Resets the flags stored, in this way `checkReachability` will set the new ones
            self.currentReachabilityFlags = nil
            // Reads the new flags
            var flags = SCNetworkReachabilityFlags()
            SCNetworkReachabilityGetFlags(reachability, &flags)
            self.checkReachability(flags: flags)
        }
        isListening = true
    }
    
    // Called inside `callbackClosure`
    private func checkReachability(flags: SCNetworkReachabilityFlags) {
        if currentReachabilityFlags != flags {
            // 🚨 Network state is changed 🚨
            // Stores the new flags
            currentReachabilityFlags = flags
        }
    }
    
    // Stops listening
    private func stop() {
        // Skips if we are not listening
        // Optional binding since `SCNetworkReachabilityCreateWithName` returns an optional object
        guard isListening,
            let reachability = reachability
            else { return }
        // Remove callback and dispatch queue
        SCNetworkReachabilitySetCallback(reachability, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachability, nil)
        isListening = false
    }
    
}

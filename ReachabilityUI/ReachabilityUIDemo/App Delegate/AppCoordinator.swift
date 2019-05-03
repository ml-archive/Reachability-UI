//
//  AppCoordinator.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    let window: UIWindow
    var children: [Coordinator] = []
    var dependencies: FullDependencies
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    var application: UIApplication!
    
    private var mainCoordinator: TabBarCoordinator!
    
    init(window: UIWindow, dependencies: FullDependencies = Dependencies.shared) {
        self.window = window
        self.dependencies = dependencies
    }
    
    func start() {
        showMain()
        window.makeKeyAndVisible()
    }
    
    // MARK: - Flows -
    
    func showMain() {
        let coordinator = TabBarCoordinator(window: window, dependencies: dependencies)
        mainCoordinator = coordinator
        coordinator.start()
        children = [coordinator]
    }
    
    
}

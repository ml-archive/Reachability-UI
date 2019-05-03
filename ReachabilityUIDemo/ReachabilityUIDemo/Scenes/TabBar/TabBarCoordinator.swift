//
//  TabBarCoordinator.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import UIKit
import ReachabilityUI

class TabBarCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let window: UIWindow
    private let dependencies: FullDependencies
    private var tabBarController: UITabBarController!
    var children: [Coordinator] = []
    private var reachabilityCoordinator: ReachabilityCoordinator!
    private let scenes: [TabBar.Scene] = [
        .hello,
        .world
    ]
    
    // MARK: - Init
    
    init(window: UIWindow, dependencies: FullDependencies) {
        self.window = window
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = UITabBarController()
        self.tabBarController = vc
        
        addCoordinators()
        
        UIView.transition(with: window,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.window.rootViewController = vc
                            self.addReachability()
        }, completion: nil)
    }
    
    // MARK: - Setup
    
    private func addCoordinators() {
        scenes.forEach { self.addCoordinator(type: $0) }
    }
    
    private func addReachability() {
        let configuration = ReachabilityConfiguration(title: "Connected",
                                                      noConnectionTitle: "No Connection",
                                                      options: nil)
        
        let coordinator = ReachabilityCoordinator(window: window,
                                                  reachabilityListenerFactory: dependencies.reachabilityListenerFactory,
                                                  configuration: configuration)
        reachabilityCoordinator = coordinator
        coordinator.start()
    }
    
    private func addCoordinator(type: TabBar.Scene) {
        
        var coordinator: Coordinator!
        let navigationController = UINavigationController()
        var vcs = tabBarController.viewControllers ?? []
        vcs += [navigationController]
        tabBarController.setViewControllers(vcs, animated: false)
        
        switch type {
        case .hello:
            coordinator = HelloCoordinator(navigationController: navigationController,
                                           dependencies: dependencies)
            navigationController.tabBarItem = UITabBarItem(title: "Hello",
                                                           image: nil,
                                                           selectedImage: nil)
        case .world:
            coordinator = WorldCoordinator(navigationController: navigationController,
                                           dependencies: dependencies)
            navigationController.tabBarItem = UITabBarItem(title: "World",
                                                           image: nil,
                                                           selectedImage: nil)
        }
        
        children.append(coordinator)
        coordinator.start()
    }
}


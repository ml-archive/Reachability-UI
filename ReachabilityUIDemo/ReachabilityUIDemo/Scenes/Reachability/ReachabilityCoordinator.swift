//
//  ReachabilityCoordinator.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 04/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import UIKit

class ReachabilityCoordinator: Coordinator {
    // MARK: - Properties
    private let window: UIWindow
    var children: [Coordinator] = []

    private var dependencies: FullDependencies
    var hasNavigationBar: Bool
    private var vc: ReachabilityViewController! //prevent ViewController from deallocating by holding a reference
    
    // MARK: - Init
    
    
    /// Init ReachabilityCoordinator
    ///
    /// - parameters:
    ///    - hasNavigationBar: default value is true.
    ///    - dependencies
    //
    init(window: UIWindow, dependencies: FullDependencies, hasNavigationBar: Bool = true) {
        self.window = window
        self.hasNavigationBar = hasNavigationBar
        self.dependencies = dependencies
    }

    func start() {
        let interactor = ReachabilityInteractor(reachabilityUIEmbedableRepository: dependencies.reachabilityUIEmbedableRepository)
        let presenter = ReachabilityPresenter(interactor: interactor,
                                              coordinator: self)
        let vc = ReachabilityViewController.instantiate(with: presenter,
                                                        window: window,
                                                        hasNavigationBar: hasNavigationBar)
        self.vc = vc

        interactor.output = presenter
        presenter.output = vc
        
        vc.addToContainer()
    }
    
}
// MARK: - Navigation Callbacks
// PRESENTER -> COORDINATOR
extension ReachabilityCoordinator: ReachabilityCoordinatorInput {
}

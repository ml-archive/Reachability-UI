//
//  ReachabilityCoordinator.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 04/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import UIKit

public class ReachabilityCoordinator {
    // MARK: - Properties
    private let window: UIWindow

    private var reachabilityUIEmbedableRepository: ReachabilityUIEmbedableRepository
    var hasNavigationBar: Bool
    private var vc: ReachabilityViewController! //prevent ViewController from deallocating by holding a reference
    
    // MARK: - Init
    
    
    /// Init ReachabilityCoordinator
    ///
    /// - parameters:
    ///    - hasNavigationBar: default value is true.
    ///    - dependencies
    ///    - height of the UIViewController. Default value is 30
    ///
    public init(window: UIWindow, reachabilityUIEmbedableRepository: ReachabilityUIEmbedableRepository, hasNavigationBar: Bool = true, with height: CGFloat = 30) {
        self.window = window
        self.hasNavigationBar = hasNavigationBar
        self.reachabilityUIEmbedableRepository = reachabilityUIEmbedableRepository
    }

    public func start() {
        let interactor = ReachabilityInteractor(reachabilityUIEmbedableRepository: reachabilityUIEmbedableRepository)
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

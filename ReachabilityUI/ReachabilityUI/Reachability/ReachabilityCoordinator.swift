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

    private var reachabilityListenerFactoryProtocol: ReachabilityListenerFactoryProtocol
    var hasNavigationBar: Bool
    private var configuration: ReachabilityConfiguration
    private var vc: ReachabilityViewController! //prevent ViewController from deallocating by holding a reference
    
    // MARK: - Init
    
    /// Init ReachabilityCoordinator
    ///
    /// - parameters:
    ///    - hasNavigationBar: default value is true.
    ///    - dependencies
    ///    - height of the UIViewController. Default value is 30
    ///
    public init(window: UIWindow, reachabilityListenerFactoryProtocol: ReachabilityListenerFactoryProtocol, hasNavigationBar: Bool = true, with configuration: ReachabilityConfiguration) {
        self.window = window
        self.hasNavigationBar = hasNavigationBar
        self.reachabilityListenerFactoryProtocol = reachabilityListenerFactoryProtocol
        self.configuration = configuration
    }

    /// Starts the ReachabilityCoordinator and by registering observers and adding the
    /// ReachabilityViewController to the window
    ///
    public func start() {
        let interactor = ReachabilityInteractor(reachabilityListenerFactoryProtocol: reachabilityListenerFactoryProtocol)
        let presenter = ReachabilityPresenter(interactor: interactor,
                                              coordinator: self)
        let vc = ReachabilityViewController.instantiate(with: presenter,
                                                        window: window,
                                                        hasNavigationBar: hasNavigationBar,
                                                        with: configuration)
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

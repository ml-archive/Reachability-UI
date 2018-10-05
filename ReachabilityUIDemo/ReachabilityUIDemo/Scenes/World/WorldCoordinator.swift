//
//  WorldCoordinator.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import UIKit

class WorldCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    private let dependencies: FullDependencies
    var children: [Coordinator] = []
    
    // MARK: - Init
    
    init(navigationController: UINavigationController, dependencies: FullDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let interactor = WorldInteractor(reachabilityListenerFactoryProtocol: dependencies.reachabilityListenerFactoryProtocol)
        let presenter = WorldPresenter(interactor: interactor, coordinator: self)
        let vc = WorldViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = vc

        navigationController.setViewControllers([vc], animated: false)
    }
}
// MARK: - Navigation Callbacks
// PRESENTER -> COORDINATOR
extension WorldCoordinator: WorldCoordinatorInput {

}

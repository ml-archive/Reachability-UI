//
//  UniversalGreetingCoordinator.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 05/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import UIKit
import ReachabilityUI

class UniversalGreetingCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    var children: [Coordinator] = []
    var reachabilityListenerFactory: ReachabilityListenerFactoryProtocol
    weak var delegate: UniversalGreetingCoordinatorDelegate?

    // MARK: - Init
    
    init(navigationController: UINavigationController,
         reachabilityListenerFactory: ReachabilityListenerFactoryProtocol) {
        self.navigationController = navigationController
        self.reachabilityListenerFactory = reachabilityListenerFactory
    }

    func start() {
        let interactor = UniversalGreetingInteractor(reachabilityListenerFactory: reachabilityListenerFactory)
        let presenter = UniversalGreetingPresenter(interactor: interactor, coordinator: self)
        let vc = UniversalGreetingViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = vc

        navigationController.present(vc, animated: true, completion: nil)
    }
}
// MARK: - Navigation Callbacks
// PRESENTER -> COORDINATOR
extension UniversalGreetingCoordinator: UniversalGreetingCoordinatorInput {
    func dismiss() {
        delegate?.coordinator(self, finishedWithSuccess: true)
        navigationController.dismiss(animated: true, completion: nil)
    }
}

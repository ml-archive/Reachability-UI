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
    var reachabilityListenerFactoryProtocol: ReachabilityListenerFactoryProtocol
    weak var delegate: UniversalGreetingCoordinatorDelegate?

    // MARK: - Init
    
    init(navigationController: UINavigationController,
         reachabilityListenerFactoryProtocol: ReachabilityListenerFactoryProtocol) {
        self.navigationController = navigationController
        self.reachabilityListenerFactoryProtocol = reachabilityListenerFactoryProtocol
    }

    func start() {
        let interactor = UniversalGreetingInteractor(reachabilityListenerFactoryProtocol: reachabilityListenerFactoryProtocol)
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

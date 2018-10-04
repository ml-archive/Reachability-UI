//
//  ReachabilityProtocols.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 04/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import UIKit

// ======== Coordinator ======== //

//protocol ReachabilityCoordinatorDelegate: class {
//    func coordinator(_ coordinator: Coordinator, finishedWithSuccess success: Bool)
//}

// PRESENTER -> COORDINATOR
protocol ReachabilityCoordinatorInput: class {
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol ReachabilityInteractorInput {
    func perform(_ request: Reachability.ReachabilityListener.Request)
}

// INTERACTOR -> PRESENTER (indirect)
protocol ReachabilityInteractorOutput: class {
    func present(_ response: Reachability.ReachabilityListener.Response)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol ReachabilityPresenterInput {
    func viewCreated()
}

// PRESENTER -> VIEW
protocol ReachabilityPresenterOutput: class {
    func display(_ displayModel: Reachability.ReachabilityListener.Display)
}

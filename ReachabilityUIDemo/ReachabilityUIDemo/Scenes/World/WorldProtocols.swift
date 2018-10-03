//
//  WorldProtocols.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import UIKit

// ======== Coordinator ======== //

//protocol WorldCoordinatorDelegate: class {
//    func coordinator(_ coordinator: Coordinator, finishedWithSuccess success: Bool)
//}

// PRESENTER -> COORDINATOR
protocol WorldCoordinatorInput: class {
    func navigate(to route: World.Route)
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol WorldInteractorInput {
    // func perform(_ request: World.Request.Work)
}

// INTERACTOR -> PRESENTER (indirect)
protocol WorldInteractorOutput: class {
    // func present(_ response: World.Response.Work)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol WorldPresenterInput {
    func viewCreated()
    func handle(_ action: World.Action)
}

// PRESENTER -> VIEW
protocol WorldPresenterOutput: class {
    // func display(_ displayModel: World.DisplayData.Work)
}

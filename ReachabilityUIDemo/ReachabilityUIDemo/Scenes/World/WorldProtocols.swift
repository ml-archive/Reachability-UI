//
//  WorldProtocols.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import UIKit

// PRESENTER -> COORDINATOR
protocol WorldCoordinatorInput: class {
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol WorldInteractorInput {
    func perform(_ request: World.ReachabilityListener.Request)
}

// INTERACTOR -> PRESENTER (indirect)
protocol WorldInteractorOutput: class {
    func present(_ response: World.ReachabilityListener.Response)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol WorldPresenterInput {
    func viewCreated()
}

// PRESENTER -> VIEW
protocol WorldPresenterOutput: class {
    func display(_ displayModel: World.ReachabilityListener.Display)
}

//
//  UniversalGreetingProtocols.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 05/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import UIKit

// ======== Coordinator ======== //

protocol UniversalGreetingCoordinatorDelegate: class {
    func coordinator(_ coordinator: Coordinator, finishedWithSuccess success: Bool)
}

// PRESENTER -> COORDINATOR
protocol UniversalGreetingCoordinatorInput: class {
    func dismiss()
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol UniversalGreetingInteractorInput {
    func perform(_ request: UniversalGreeting.ReachabilityListener.Request)
}

// INTERACTOR -> PRESENTER (indirect)
protocol UniversalGreetingInteractorOutput: class {
    func present(_ response: UniversalGreeting.ReachabilityListener.Response)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol UniversalGreetingPresenterInput {
    func viewCreated()
    func dismiss()
}

// PRESENTER -> VIEW
protocol UniversalGreetingPresenterOutput: class {
    func display(_ displayModel: UniversalGreeting.ReachabilityListener.Display)
}

//
//  HelloProtocols.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation
import UIKit

// ======== Coordinator ======== //

// PRESENTER -> COORDINATOR
protocol HelloCoordinatorInput: class {
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol HelloInteractorInput {
     func perform(_ request: Hello.ReachabilityListener.Request)
}

// INTERACTOR -> PRESENTER (indirect)
protocol HelloInteractorOutput: class {
     func present(_ response: Hello.ReachabilityListener.Response)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol HelloPresenterInput {
    func viewCreated()
    var rowCount: Int { get }
    func configure(_ view: GreetingCellInputDelegate, indexPath: IndexPath)
}

// PRESENTER -> VIEW
protocol HelloPresenterOutput: class {
     func display(_ displayModel: Hello.ReachabilityListener.Display)
}

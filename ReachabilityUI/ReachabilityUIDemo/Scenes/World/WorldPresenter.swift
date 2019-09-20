//
//  WorldPresenter.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation

class WorldPresenter {
    // MARK: - Properties
    let interactor: WorldInteractorInput
    weak var coordinator: WorldCoordinatorInput?
    weak var output: WorldPresenterOutput?

    // MARK: - Init
    init(interactor: WorldInteractorInput, coordinator: WorldCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension WorldPresenter: WorldPresenterInput {
    func viewCreated() {
        interactor.perform(World.ReachabilityListener.Request())
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension WorldPresenter: WorldInteractorOutput {
    func present(_ response: World.ReachabilityListener.Response) {
        output?.display(World.ReachabilityListener.Display(reachabilityNotification: response.reachabilityNotification))
    }
}

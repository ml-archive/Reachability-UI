//
//  ReachabilityPresenter.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 04/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation

class ReachabilityPresenter {
    // MARK: - Properties
    let interactor: ReachabilityInteractorInput
    weak var coordinator: ReachabilityCoordinatorInput?
    weak var output: ReachabilityPresenterOutput?

    // MARK: - Init
    init(interactor: ReachabilityInteractorInput, coordinator: ReachabilityCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension ReachabilityPresenter: ReachabilityPresenterInput {
    func viewCreated() {
        interactor.perform(Reachability.ReachabilityListener.Request())
    }

}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension ReachabilityPresenter: ReachabilityInteractorOutput {
    func present(_ response: Reachability.ReachabilityListener.Response) {
        output?.display(Reachability.ReachabilityListener.Display(notification: response.notification))
    }
}

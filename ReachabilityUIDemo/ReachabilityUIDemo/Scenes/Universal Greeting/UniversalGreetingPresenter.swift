//
//  UniversalGreetingPresenter.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 05/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation

class UniversalGreetingPresenter {
    // MARK: - Properties
    let interactor: UniversalGreetingInteractorInput
    weak var coordinator: UniversalGreetingCoordinatorInput?
    weak var output: UniversalGreetingPresenterOutput?

    // MARK: - Init
    init(interactor: UniversalGreetingInteractorInput, coordinator: UniversalGreetingCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension UniversalGreetingPresenter: UniversalGreetingPresenterInput {
    func dismiss() {
        coordinator?.dismiss()
    }
    
    func viewCreated() {
        interactor.perform(UniversalGreeting.ReachabilityListener.Request())
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension UniversalGreetingPresenter: UniversalGreetingInteractorOutput {
    func present(_ response: UniversalGreeting.ReachabilityListener.Response) {
        output?.display(UniversalGreeting.ReachabilityListener.Display(isConnected: response.isConnected))
    }
}

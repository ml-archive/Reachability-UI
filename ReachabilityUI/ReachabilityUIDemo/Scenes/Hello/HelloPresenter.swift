//
//  HelloPresenter.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation

class HelloPresenter {
    
    // MARK: - Properties
    
    let interactor: HelloInteractorInput
    weak var coordinator: HelloCoordinatorInput?
    weak var output: HelloPresenterOutput?
    private let greetings = [ "Hello", "Hej", "Ciao", "Salut", "Hei", "Hallo", "Namaste", "Salaam"]
    
    // MARK: - Init
    
    init(interactor: HelloInteractorInput, coordinator: HelloCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension HelloPresenter: HelloPresenterInput {
    func didSelect() {
        coordinator?.presentUniversalVC()
    }
    
    func viewCreated() {
        interactor.perform(Hello.ReachabilityListener.Request())
    }
    
    var rowCount: Int {
        return greetings.count
    }
    
    func configure(_ view: GreetingCellInputDelegate, indexPath: IndexPath) {
        let row = indexPath.row
        guard row < greetings.count else { return }
        view.configure(greetings[row])
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension HelloPresenter: HelloInteractorOutput {
    func present(_ response: Hello.ReachabilityListener.Response) {
        output?.display(Hello.ReachabilityListener.Display(reachabilityNotification: response.reachabilityNotification))
    }
}

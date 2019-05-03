//
//  UniversalGreetingViewController.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 05/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import UIKit

class UniversalGreetingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        }
    }
    
    // MARK: - Properties
    private var presenter: UniversalGreetingPresenterInput!

    // MARK: - Init
    class func instantiate(with presenter: UniversalGreetingPresenterInput) -> UniversalGreetingViewController {
        let name = "\(UniversalGreetingViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! UniversalGreetingViewController
        vc.presenter = presenter
        return vc
    }

    // MARK: - View Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewCreated()
    }

    // MARK: - Callbacks -
    
    @objc private func closeTapped() {
        presenter.dismiss()
    }

}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension UniversalGreetingViewController: UniversalGreetingPresenterOutput {
    func display(_ displayModel: UniversalGreeting.ReachabilityListener.Display) {
        
    }
}

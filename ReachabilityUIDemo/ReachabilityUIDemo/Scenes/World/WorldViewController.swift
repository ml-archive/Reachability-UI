//
//  WorldViewController.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import UIKit

class WorldViewController: UIViewController {
    // MARK: - Outlets

    // MARK: - Properties
    private var presenter: WorldPresenterInput!

    // MARK: - Init
    class func instantiate(with presenter: WorldPresenterInput) -> WorldViewController {
        let name = "\(WorldViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! WorldViewController
        vc.presenter = presenter
        return vc
    }

    // MARK: - View Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewCreated()
    }

    // MARK: - Callbacks -

}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension WorldViewController: WorldPresenterOutput {

}

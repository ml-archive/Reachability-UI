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

    @IBOutlet weak var containerViewTop: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
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
    func display(_ displayModel: World.ReachabilityListener.Display) {
        containerViewTop.constant = displayModel.isConnected ? 0 : Sizes.Height.reachabilityView
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}

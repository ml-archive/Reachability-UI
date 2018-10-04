//
//  ReachabilityViewController.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 04/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import UIKit

class ReachabilityViewController: UIViewController {
    
    private enum State: Int {
        case show
        case hide
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak private var titleLabel: UILabel!

    private var state: State! {
        didSet {
            adjustLabelBasedOnConfiguration(state)
            DispatchQueue.main.async {
                let statusBarHeight = UIApplication.shared.statusBarFrame.height
                let navigationBarHeight = self.hasNavigationBar ? UINavigationController().navigationBar.frame.height : 0
                let finalY = self.state == .hide ? -self.configuration.height : statusBarHeight + navigationBarHeight
                UIView.animate(withDuration: self.view.frame.height != self.configuration.height ? 0 : 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: finalY, width: self.window.frame.width, height: self.configuration.height)
                    self.window.layoutIfNeeded()
                })
                self.window.bringSubviewToFront(self.view)
            }
        }
    }
    private var hasNavigationBar: Bool = true
    
    // MARK: - Properties
    
    private var presenter: ReachabilityPresenterInput!
    private var window: UIWindow!
    private var configuration: ReachabilityConfiguration!
    private var isConnected: Bool = true {
        didSet {
            state = isConnected ? .hide : .show
        }
    }
    
    // MARK: - Init
    
    class func instantiate(with presenter: ReachabilityPresenterInput,
                           window: UIWindow,
                           hasNavigationBar: Bool,
                           with configuration: ReachabilityConfiguration) -> ReachabilityViewController {
        let name = "\(ReachabilityViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! ReachabilityViewController
        vc.presenter = presenter
        vc.window = window
        vc.hasNavigationBar = hasNavigationBar
        vc.configuration = configuration
        return vc
    }
    
    public func addToContainer() {
        guard window != nil else { return }
        DispatchQueue.main.async {
            self.window.addSubview(self.view)
            self.view.bringSubviewToFront(self.window)
        }
    }
    
    // MARK: - View Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        presenter.viewCreated()
    }
    
    // MARK: - Helpers
    
    private func adjustLabelBasedOnConfiguration(_ state: State) {
        titleLabel.font = configuration.font
        titleLabel.textAlignment = configuration.textAlignment
        switch state {
        case .show:
            titleLabel.text = configuration.noConnectionTitle
            titleLabel.textColor = configuration.noConnectionTitleColor
            view.backgroundColor = configuration.noConnectionBackgroundColor
        case .hide:
            titleLabel.text = configuration.title
            titleLabel.textColor = configuration.titleColor
            view.backgroundColor = configuration.backgroundColor
        }
    }
    
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension ReachabilityViewController: ReachabilityPresenterOutput {
    func display(_ displayModel: Reachability.ReachabilityListener.Display) {
        self.isConnected = displayModel.isConnected
    }
}

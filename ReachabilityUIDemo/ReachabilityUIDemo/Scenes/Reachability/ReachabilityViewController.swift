//
//  ReachabilityViewController.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 04/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import UIKit

class ReachabilityViewController: UIViewController {
    
    enum State: Int {
        case show
        case hide
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!

    private var state: State! {
        didSet {
            DispatchQueue.main.async {
                let statusBarHeight = UIApplication.shared.statusBarFrame.height
                let navigationBarHeight = self.hasNavigationBar ? UINavigationController().navigationBar.frame.height : 0
                let finalY = self.state == .hide ? -Sizes.Height.reachabilityView : statusBarHeight + navigationBarHeight
                UIView.animate(withDuration: self.view.frame.height != Sizes.Height.reachabilityView ? 0 : 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: finalY, width: self.window.frame.width, height: Sizes.Height.reachabilityView)
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
    private var isConnected: Bool = true {
        didSet {
            state = isConnected ? .hide : .show
        }
    }
    
    // MARK: - Init
    
    class func instantiate(with presenter: ReachabilityPresenterInput, window: UIWindow, hasNavigationBar: Bool) -> ReachabilityViewController {
        let name = "\(ReachabilityViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! ReachabilityViewController
        vc.presenter = presenter
        vc.window = window
        vc.hasNavigationBar = hasNavigationBar
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
    
    // MARK: - Callbacks -
    
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension ReachabilityViewController: ReachabilityPresenterOutput {
    func display(_ displayModel: Reachability.ReachabilityListener.Display) {
        self.isConnected = displayModel.isConnected
    }
}

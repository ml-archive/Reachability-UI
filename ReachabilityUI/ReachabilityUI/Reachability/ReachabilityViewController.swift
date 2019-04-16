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
                self.animatePositionChange(self.state, animation: self.configuration.options[.animation] as! ReachabilityConfiguration.Animation)
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
    
    class func instantiate(
        with presenter: ReachabilityPresenterInput,
        window: UIWindow,
        hasNavigationBar: Bool,
        configuration: ReachabilityConfiguration
        ) -> ReachabilityViewController {
        let name = "\(ReachabilityViewController.self)"
        let storyboardBundle = Bundle(for: ReachabilityViewController.self)
        let storyboard = UIStoryboard(name: name, bundle: storyboardBundle)
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
            let height = self.configuration.options[.height] as! CGFloat
            self.view.frame = CGRect(x: 0, y: -height, width: self.window.frame.width, height: height)
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
        titleLabel.font = configuration.options[.font] as? UIFont
        titleLabel.textAlignment = configuration.options[.textAlignment] as! NSTextAlignment
        switch state {
        case .show:
            titleLabel.text = configuration.noConnectionTitle
            titleLabel.textColor = configuration.options[.noConnectionTitleColor] as? UIColor
            view.backgroundColor = configuration.options[.noConnectionBackgroundColor] as? UIColor
        case .hide:
            titleLabel.text = configuration.title
            titleLabel.textColor = configuration.options[.titleColor] as? UIColor
            view.backgroundColor = configuration.options[.backgroundColor] as? UIColor
        }
    }
    
    private func animatePositionChange(_ state: State, animation: ReachabilityConfiguration.Animation) {
        let height = self.configuration.options[.height] as! CGFloat
        // change current alpha state
        view.alpha = state == .hide ? 1 : 0
        
        // figure out View poistion
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = hasNavigationBar ? UINavigationController().navigationBar.frame.height : 0
        let finalY = state == .hide ? -height : statusBarHeight + navigationBarHeight
        
        //figure out view alpha
        let finalAlpha = state == .hide && (animation == .fadeInOut || animation == .slideAndFadeInOut) ? 0 : 1
        
        // set animation durations
        let animated = view.frame.height == height
        let animationDuration = animated ? 0.3 : 0.0
        let delay = state == .hide ? 0.75 : 0.0
        
        switch animation {
        case .fadeInOut:
            fadeInOut(state,
                      delay: delay,
                      duration: animationDuration,
                      yPosition: finalY,
                      alpha: finalAlpha)
        case .slideInOut:
            slideInOut(state,
                      delay: delay,
                      duration: animationDuration,
                      yPosition: finalY,
                      alpha: finalAlpha)
        case .slideAndFadeInOut:
            slideAndFadeInOut(state,
                      delay: delay,
                      duration: animationDuration,
                      yPosition: finalY,
                      alpha: finalAlpha)
        }
    }
    
    private func fadeInOut(_ state: State, delay: TimeInterval, duration: TimeInterval, yPosition: CGFloat, alpha: Int) {

        UIView.animate(withDuration: duration,
                       delay: delay,
                       animations: {
            self.view.alpha = state == .hide ? 0 : 1
            self.window.layoutIfNeeded()
        }) { (_) in
            self.view.frame = CGRect(x: 0,
                                y: yPosition,
                                width: self.window.frame.width,
                                height: self.configuration.options[.height] as! CGFloat)
            self.window.layoutIfNeeded()
        }
        
        
    }
    
    private func slideInOut(_ state: State, delay: TimeInterval, duration: TimeInterval, yPosition: CGFloat, alpha: Int) {
        view.alpha = 1
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       animations:
            {
                self.view.frame = CGRect(x: 0,
                                         y: yPosition,
                                         width: self.window.frame.width,
                                         height: self.configuration.options[.height] as! CGFloat)
                self.window.layoutIfNeeded()
        })
    }
    
    private func slideAndFadeInOut(_ state: State, delay: TimeInterval, duration: TimeInterval, yPosition: CGFloat, alpha: Int) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       animations:
            {
                self.view.alpha = state == .hide ? 0 : 1
                self.view.frame = CGRect(x: 0,
                                         y: yPosition,
                                         width: self.window.frame.width,
                                         height: self.configuration.options[.height] as! CGFloat)
                self.window.layoutIfNeeded()
        })
    }
    
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension ReachabilityViewController: ReachabilityPresenterOutput {
    func display(_ displayModel: Reachability.ReachabilityListener.Display) {
        self.isConnected = displayModel.isConnected
    }
}

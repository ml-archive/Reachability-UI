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
    
    private enum StartingPoint {
        case top
        case bottom
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak private var titleLabel: UILabel!
    
    private var state: State! {
        didSet {
            adjustLabelBasedOnConfiguration(state)
            DispatchQueue.main.async {
                if let animation = self.configuration.options[.animation] as? ReachabilityConfiguration.Animation {
                    self.prepareForAnimatingPositionChange(self.state, animation: animation)
                    self.window.bringSubviewToFront(self.view)
                }
            }
        }
    }
    private var hasNavigationBar: Bool = true
    private var hasTabBar: Bool = false
    
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
            if let height = self.configuration.options[.height] as? CGFloat,
                let animationType = self.configuration.options[.animation] as? ReachabilityConfiguration.Animation
            {
                var yStartPosition:CGFloat = 0
                
                switch animationType {
                case .slideAndFadeInOutFromBottom, .slideInOutFromBottom:
                    yStartPosition = UIScreen.main.bounds.height + height
                default:
                    yStartPosition = -height
                }
                self.view.frame = CGRect(x: 0, y: yStartPosition, width: self.window.frame.width, height: height)
                
                self.window.addSubview(self.view)
                self.view.bringSubviewToFront(self.window)
            }
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
        if let alignment = configuration.options[.textAlignment] as? NSTextAlignment {
            titleLabel.textAlignment = alignment
        }
        
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
    
    private func prepareForAnimatingPositionChange(_ state: State, animation: ReachabilityConfiguration.Animation) {
        if let height = self.configuration.options[.height] as? CGFloat,
            let appearance = self.configuration.options[.appearance] as? ReachabilityConfiguration.Appearance,
            let appearanceAdjustment = self.configuration.options[.appearanceAdjustment] as? CGFloat
        {
            // change current alpha state
            view.alpha = state == .hide ? 1 : 0
            
            // figure out View poistion
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            let navigationBarHeight = hasNavigationBar ? UINavigationController().navigationBar.frame.height : 0
            let screenBounds = UIScreen.main.bounds
            var finalY: CGFloat = 0
            
            switch appearance {
            case .top:
                finalY = state == .hide ? -height : statusBarHeight + navigationBarHeight + appearanceAdjustment
            case .center:
                finalY = state == .hide ? -height : screenBounds.midY + appearanceAdjustment
            case .bottom:
                finalY = state == .hide ? -height : screenBounds.height - height + appearanceAdjustment
            }
            
            //figure out view alpha
            let finalAlpha = state == .hide && (animation == .fadeInOut || animation == .slideAndFadeInOutFromTop || animation == .slideAndFadeInOutFromBottom) ? 0 : 1
            
            // set animation durations
            let animated = view.frame.height == height
            let animationDuration = animated ? 0.3 : 0.0
            let delay = state == .hide ? 0.75 : 0.0
            
            run(animation, with: delay, for: animationDuration, to: finalY, to: finalAlpha)
        }
    }
    
    private func run(_ animation: ReachabilityConfiguration.Animation, with delay: TimeInterval, for duration: TimeInterval, to yPosition: CGFloat, to alpha: Int) {
        switch animation {
        case .fadeInOut:
            fadeInOut(state,
                      delay: delay,
                      duration: duration,
                      yPosition: yPosition,
                      alpha: alpha)
        case .slideInOutFromTop:
            slideInOut(state,
                       startingPoint: .top,
                       delay: delay,
                       duration: duration,
                       yPosition: yPosition,
                       alpha: alpha)
        case .slideAndFadeInOutFromTop:
            slideAndFadeInOut(state,
                              startingPoint: .top,
                              delay: delay,
                              duration: duration,
                              yPosition: yPosition,
                              alpha: alpha)
        case .slideInOutFromBottom:
            slideInOut(state,
                       startingPoint: .bottom,
                       delay: delay,
                       duration: duration,
                       yPosition: yPosition,
                       alpha: alpha)
        case .slideAndFadeInOutFromBottom:
            slideAndFadeInOut(state,
                              startingPoint: .bottom,
                              delay: delay,
                              duration: duration,
                              yPosition: yPosition,
                              alpha: alpha)
        }
    }
    
    private func fadeInOut(_ state: State, delay: TimeInterval, duration: TimeInterval, yPosition: CGFloat, alpha: Int) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       animations: {
                        self.view.alpha = state == .hide ? 0 : 1
                        self.window.layoutIfNeeded()
        }) { (_) in
            if let height = self.configuration.options[.height] as? CGFloat {
                self.view.frame = CGRect(x: 0,
                                         y: yPosition,
                                         width: self.window.frame.width,
                                         height: height)
                self.window.layoutIfNeeded()
            }
        }
    }
    
    private func slideInOut(_ state: State, startingPoint: StartingPoint, delay: TimeInterval, duration: TimeInterval, yPosition: CGFloat, alpha: Int) {
        if let height = self.configuration.options[.height] as? CGFloat {
            view.alpha = 1
            var internalY = yPosition
            if startingPoint == .bottom && state == .hide {
                internalY = UIScreen.main.bounds.height + height
            }
            
            UIView.animate(withDuration: duration,
                           delay: delay,
                           animations:
                {
                    self.view.frame = CGRect(x: 0,
                                             y: internalY,
                                             width: self.window.frame.width,
                                             height: height)
                    self.window.layoutIfNeeded()
            })
        }
    }
    
    private func slideAndFadeInOut(_ state: State, startingPoint: StartingPoint, delay: TimeInterval, duration: TimeInterval, yPosition: CGFloat, alpha: Int) {
        if let height = self.configuration.options[.height] as? CGFloat {
            var internalY = yPosition
            if startingPoint == .bottom && state == .hide {
                internalY = UIScreen.main.bounds.height + height
            }
            
            UIView.animate(withDuration: duration,
                           delay: delay,
                           animations:
                {
                    self.view.alpha = state == .hide ? 0 : 1
                    self.view.frame = CGRect(x: 0,
                                             y: internalY,
                                             width: self.window.frame.width,
                                             height: self.configuration.options[.height] as! CGFloat)
                    self.window.layoutIfNeeded()
            })
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

//
//  ReachabilityModels.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 04/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import Foundation

enum Reachability {
    
    struct ReachabilityListener {}
}

extension Reachability.ReachabilityListener {
    struct Request {}
    struct Response {
        let isConnected: Bool
    }
    struct Display {
        let isConnected: Bool
    }
}

public struct ReachabilityConfiguration {
    let title: String
    let noConnectionTitle: String
    let options: [ReachabilityConfiguration.Key : Any]
    let defaultOptionsDict: [ReachabilityConfiguration.Key : Any] = [.titleColor : UIColor.white,
                                                              .noConnectionTitleColor : UIColor.white,
                                                              .noConnectionBackgroundColor : UIColor.red.withAlphaComponent(0.6),
                                                              .backgroundColor : UIColor.green.withAlphaComponent(0.6),
                                                              .height : CGFloat(30),
                                                              .font : UIFont.systemFont(ofSize: 12),
                                                              .textAlignment: NSTextAlignment.center,
                                                              .animation : Animation.fadeInOut,
                                                              .appearance : Appearance.top,
                                                              .appearanceAdjustment : CGFloat(0)]
    
    public init(title: String, noConnectionTitle: String, options: [ReachabilityConfiguration.Key : Any]?) {
        self.title = title
        self.noConnectionTitle = noConnectionTitle
        
        var finalOptionsDict = [ReachabilityConfiguration.Key : Any]()
        if let options = options {
            
            //titleColor
            if let titleColor = options[.titleColor] as? UIColor {
                finalOptionsDict[.titleColor] = titleColor
            } else {
                finalOptionsDict[.titleColor] = defaultOptionsDict[.titleColor]
            }
            
            //noConnectionTitleColor
            if let noConnectionTitleColor = options[.noConnectionTitleColor] as? UIColor {
                finalOptionsDict[.noConnectionTitleColor] = noConnectionTitleColor
            } else {
                finalOptionsDict[.noConnectionTitleColor] = defaultOptionsDict[.noConnectionTitleColor]
            }
            
            //noConnectionBackgroundColor
            if let noConnectionBackgroundColor = options[.noConnectionBackgroundColor] as? UIColor {
                finalOptionsDict[.noConnectionBackgroundColor] = noConnectionBackgroundColor
            } else {
                finalOptionsDict[.noConnectionBackgroundColor] = defaultOptionsDict[.noConnectionBackgroundColor]
            }
            
            //backgroundColor
            if let backgroundColor = options[.backgroundColor] as? UIColor {
                finalOptionsDict[.backgroundColor] = backgroundColor
            } else {
                finalOptionsDict[.backgroundColor] = defaultOptionsDict[.backgroundColor]
            }
            
            //height
            if let height = options[.height] as? CGFloat {
                finalOptionsDict[.height] = height
            } else {
                finalOptionsDict[.height] = defaultOptionsDict[.height]
            }
            
            //font
            if let font = options[.font] as? UIFont {
                finalOptionsDict[.font] = font
            } else {
                finalOptionsDict[.font] = defaultOptionsDict[.font]
            }
            
            //textAlignment
            if let textAlignment = options[.textAlignment] as? NSTextAlignment {
                finalOptionsDict[.textAlignment] = textAlignment
            } else {
                finalOptionsDict[.textAlignment] = defaultOptionsDict[.textAlignment]
            }
            
            //animation
            if let animation = options[.animation] as? Animation {
                finalOptionsDict[.animation] = animation
            } else {
                finalOptionsDict[.animation] = defaultOptionsDict[.animation]
            }
            
            //appearance
            if let appearance = options[.appearance] as? Appearance {
                finalOptionsDict[.appearance] = appearance
            } else {
                finalOptionsDict[.appearance] = defaultOptionsDict[.appearance]
            }
            
            //appearanceAdjustment
            if let appearanceAdjustment = options[.appearanceAdjustment] as? CGFloat {
                finalOptionsDict[.appearanceAdjustment] = appearanceAdjustment
            } else {
                finalOptionsDict[.appearanceAdjustment] = defaultOptionsDict[.appearanceAdjustment]
            }
            
        } else {
            finalOptionsDict = defaultOptionsDict
        }
        
        self.options = finalOptionsDict
    }
}

extension ReachabilityConfiguration {
    
    public enum Key: String {
        case titleColor //Has to be of type UIColor
        case noConnectionTitleColor //Has to be of type UIColor
        case noConnectionBackgroundColor //Has to be of type UIColor
        case backgroundColor //Has to be of type UIColor
        case height //Has to be of type CGFloat
        case font //Has to be of type UIFont
        case textAlignment //Has to be of type NSTextAlignment
        case animation //Has to be of type ReachabilityConfiguration.Animation
        case appearance //Has to be of type ReachabilityConfiguration.Appearance
        case appearanceAdjustment //Has to be of type CGFloat
    }
    
    public enum Animation {
        /// the banner will appear/dissapear from the screen by changing the view's alpha value
        case fadeInOut
        /// the banner will appear/dissapear from the screen by moving it's frame on and off the view from the top
        case slideInOutFromTop
        /// the banner will appear/dissapear from the screen by moving it's frame on and off the view from the top, while simulatiously changing it's alpha values
        case slideAndFadeInOutFromTop
        /// the banner will appear/dissapear from the screen by moving it's frame on and off the view from the bottom
        case slideInOutFromBottom
        /// the banner will appear/dissapear from the screen by moving it's frame on and off the view from the bottom, while simulatiously changing it's alpha values
        case slideAndFadeInOutFromBottom
    }
    
    public enum Appearance {
        case top
        case center
        case bottom
    }
    
}

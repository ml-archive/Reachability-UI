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
    let noConnectionTitle: String
    let noConnectionTitleColor: UIColor
    let noConnectionBackgroundColor: UIColor
    let title: String
    let titleColor: UIColor
    let backgroundColor: UIColor
    let height: CGFloat
    let font: UIFont
    let textAlignment: NSTextAlignment
    
    public init(noConnectionTitle: String,
                noConnectionTitleColor: UIColor,
                noConnectionBackgroundColor: UIColor,
                title: String,
                titleColor: UIColor,
                backgroundColor: UIColor,
                height: CGFloat,
                font: UIFont,
                textAlignment: NSTextAlignment) {
        self.noConnectionTitle = noConnectionTitle
        self.noConnectionTitleColor = noConnectionTitleColor
        self.noConnectionBackgroundColor = noConnectionBackgroundColor
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.height = height
        self.font = font
        self.textAlignment = textAlignment
    }
}

//
//  Coordinator.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//Copyright © 2018 Nodes. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var children: [Coordinator] { get set }
    func start()
}

//
//  GreetingCell.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import UIKit

protocol GreetingCellInputDelegate: class {
    func configure(_ title: String)
}

class GreetingCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

extension GreetingCell: GreetingCellInputDelegate {
    func configure(_ title: String) {
        titleLabel.text = title
    }
}

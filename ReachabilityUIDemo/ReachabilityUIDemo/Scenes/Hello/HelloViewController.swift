//
//  HelloViewController.swift
//  ReachabilityUIDemo
//
//  Created by Andrei Hogea on 03/10/2018.
//  Copyright (c) 2018 Nodes. All rights reserved.
//

import UIKit

class HelloViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.tableFooterView = UIView()
            tableView.register(UINib(nibName: "\(GreetingCell.self)", bundle: .main), forCellReuseIdentifier: "\(GreetingCell.self)")
        }
    }
    
    // MARK: - Properties
    
    private var presenter: HelloPresenterInput!

    // MARK: - Init
    
    class func instantiate(with presenter: HelloPresenterInput) -> HelloViewController {
        let name = "\(HelloViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! HelloViewController
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

// MARK: UITableView delegates

extension HelloViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rowCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(GreetingCell.self)", for: indexPath) as! GreetingCell
        presenter.configure(cell, indexPath: indexPath)
        return cell
    }
}

extension HelloViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelect()
    }
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension HelloViewController: HelloPresenterOutput {
    func display(_ displayModel: Hello.ReachabilityListener.Display) {
        tableViewTop.constant = displayModel.isConnected ? 0 : Sizes.Height.reachabilityView
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}

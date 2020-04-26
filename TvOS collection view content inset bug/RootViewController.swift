//
//  RootViewController.swift
//  TvOS collection view prefetch bug
//
//  Created by Diogo on 25/04/20.
//  Copyright © 2020 Diogo Tridapalli. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private lazy var tabViewController = UITabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(tabViewController)
        tabViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabViewController.view)

        NSLayoutConstraint.activate([
            tabViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            tabViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            tabViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            tabViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tabViewController.didMove(toParent: self)

        tabViewController.viewControllers = [
            CollectionViewController(items: 4),
            CollectionViewController(items: 22),
            CollectionViewController(items: 24)
        ]
    }
}

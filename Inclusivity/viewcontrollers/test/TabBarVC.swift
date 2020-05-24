//
//  TabBarVC.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 05/08/2019.
//  Copyright © 2019 makit. All rights reserved.
//

import UIKit
import Anchorage

public class TabBarVC: UITabBarController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstViewController = FirstTestVC()
                
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let secondViewController = SecondTestVC()

        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let tabBarList = [firstViewController, secondViewController]

        viewControllers = tabBarList
    }
}

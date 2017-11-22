//
//  AppearanceManager.swift
//  TabBarExample
//
//  Created by M.Kamran on 11/22/17.
//  Copyright © 2017 M.Kamran. All rights reserved.
//

import UIKit

class AppearanceManager {
    
    class func updateNavigationBar() {
        let navigatoinBar = UINavigationBar.appearance()
        navigatoinBar.barTintColor = UIColor(red: 164.0/255.0, green: 13.0/255.0, blue: 1.0, alpha: 1.0)
        navigatoinBar.tintColor = .white
        navigatoinBar.isTranslucent = false
    }
}

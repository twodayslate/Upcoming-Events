//
//  File.swift
//  events
//
//  Created by Zachary Gorak on 7/16/19.
//  Copyright © 2019 Zachary Gorak. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /// Set's the `navigationBar`, style, background to Facebook blue and the titles to white
    func setEventNavigationBarStyle() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = UIColor.Facebook.blue
        self.navigationController?.navigationBar.tintColor = UIColor.Facebook.white
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.Facebook.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.Facebook.white]
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
}

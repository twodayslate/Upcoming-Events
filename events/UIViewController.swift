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
    /**
     Set's the `navigationBar`, style, background to Facebook blue and the titles to white
     */
    func setEventNavigationBarStyle() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.barTintColor = UIColor.Facebook.blue
        self.navigationController?.navigationBar.tintColor = UIColor.Facebook.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.Facebook.white]
        self.navigationController?.navigationBar.isTranslucent = false
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.Facebook.white]
        }
        
// Uncomment if building with Xcode 11+, this won't compile on Xcode 10.2 and below
//        if #available(iOS 13.0, *) {
//            // In iOS 13 and later, a large title navigation bar doesn’t
//            // include a background material or shadow by default.
//            // Also, a large title transitions to a standard title as
//            // people begin scrolling the content
//            // https://developer.apple.com/design/human-interface-guidelines/ios/bars/navigation-bars/
//            let app = UINavigationBarAppearance()
//            app.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.Facebook.white]
//            app.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.Facebook.white]
//            app.backgroundColor = UIColor.Facebook.blue
//            self.navigationController?.navigationBar.compactAppearance = app
//            self.navigationController?.navigationBar.standardAppearance = app
//            self.navigationController?.navigationBar.scrollEdgeAppearance = app
//        }
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
}

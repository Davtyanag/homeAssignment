//
//  UIColor+Extension.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit

extension UIColor {

    struct AppColors {
        static let Background = UIColor.rgb(r: 23, g: 36, b: 45)
        static let Yellow = UIColor.rgb(r: 253, g: 187, b: 98)
        static let Purple = UIColor.rgb(r: 133, g: 117, b: 215)
        static let Gray = UIColor.grayColorWithUniversalInt(value: 60)
        static let White = UIColor.grayColorWithUniversalInt(value: 253)
    }

    class func grayColorWithUniversalInt(value: Int) -> UIColor {
        let full: CGFloat = 255.0
        let percent:CGFloat = CGFloat(value) / full
        return UIColor(red: percent, green: percent, blue: percent, alpha: 1.0)
    }

    class func rgb(r: Int, g: Int, b: Int) -> UIColor {
        let full: CGFloat = 255.0
        return UIColor(red: CGFloat(r) / full, green: CGFloat(g) / full, blue: CGFloat(b) / full, alpha: 1.0)
    }
    

}

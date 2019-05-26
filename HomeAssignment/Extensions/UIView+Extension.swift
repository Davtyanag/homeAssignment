//
//  UIView+Extension.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit

extension UIView {
    func rounded(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

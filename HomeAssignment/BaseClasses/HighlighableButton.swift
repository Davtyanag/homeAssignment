//
//  HighlighableButton.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit

class HighlighableButton: UIButton {
    var bgColor = UIColor.grayColorWithUniversalInt(value: 160)
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? bgColor.withAlphaComponent(0.5) : bgColor
        }
    }
}

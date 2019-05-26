//
//  FeedBackgroundView.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit

enum Direction {
    case horizontal
    case vertical
}

class FeedBackgroundView: UIView {

    private let gradientLayerName = "gradient"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func removeLayer() {
        for layer in self.layer.sublayers ?? [] {
            if layer.name == gradientLayerName {
                layer.removeFromSuperlayer()
            }
        }
    }

    func setBorder(cornerRadius: CGFloat, colors: [UIColor], lineWidth: CGFloat = 5, direction: Direction = .horizontal) {
        self.removeLayer()
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        let gradient = CAGradientLayer()
        gradient.name = gradientLayerName
        gradient.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        gradient.colors = colors.map({ (color) -> CGColor in
            color.cgColor
        })

        switch direction {
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        case .vertical:
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
        }

        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        shape.path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: lineWidth,
                                                                   dy: lineWidth), cornerRadius: cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        self.layer.addSublayer(gradient)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

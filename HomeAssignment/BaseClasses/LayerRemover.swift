//
//  LayerRemover.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import Foundation
import QuartzCore

protocol LayerRemoverDelegate: class {
    func removedLayer(name: String)
}

class LayerRemover: NSObject, CAAnimationDelegate {

    weak var removerDelegate: LayerRemoverDelegate? = nil
    private weak var layer: CALayer?

    init(for layer: CALayer) {
        self.layer = layer
        super.init()
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        removerDelegate?.removedLayer(name: layer?.name ?? "")
        layer?.removeFromSuperlayer()
    }
}

//
//  UITableView+Extension.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit
extension UITableView {
    func registerForCells(cells: [AnyClass]) {
        for cell in cells {
            let identifier = String(describing: cell)
            let nib = UINib(nibName: identifier, bundle: nil)
            register(nib, forCellReuseIdentifier: identifier)
            register(cell, forCellReuseIdentifier: identifier)
        }
    }
}


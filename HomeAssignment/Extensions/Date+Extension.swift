//
//  Date+Extension.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import Foundation

extension Date {
    func dateBySubstructingHours(hours: Int) -> Date {
        let date = Date()
        let earlyDate = Calendar.current.date(
            byAdding: .hour,
            value: -hours,
            to: date)
        return earlyDate ?? date
    }
}

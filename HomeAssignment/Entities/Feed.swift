//
//  Feed.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit

enum FeedType {
    case white
    case gray
    case colorful
}

struct Feed {
    var text: String
    var imageName: String
    var badgeValue: Int
    var type: FeedType
}

//
//  FeedCell.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {

    let collectionView: FeedCollectionView = {
        let view = FeedCollectionView.init(frame: CGRect.zero)
        view.backgroundColor = UIColor.clear
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear

        contentView.addSubview(collectionView)

        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()

    }

    func setFeeds(feeds:[Feed]) {
        collectionView.setData(feeds: feeds)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func updateConstraints() {
        super.updateConstraints()
        if !didSetupConstraints {
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.bounds = CGRect(x: 0.0, y: 0.0, width: 9999.0, height: 9999.0)

            collectionView.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(0.0)
                make.bottom.equalToSuperview().priority(999.0)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(screenSize.width * 0.221)
            }
        }
        super.updateConstraints()
    }
}

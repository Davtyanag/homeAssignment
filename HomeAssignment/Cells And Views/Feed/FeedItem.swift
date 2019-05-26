//
//  FeedItem.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit

class FeedItem: UICollectionViewCell {

    private var feed: Feed?

    let bgView: FeedBackgroundView = {
        let view = FeedBackgroundView.init(frame: CGRect.zero)
        view.backgroundColor = UIColor.clear
        return view
    }()

    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.clear
        return view
    }()

    let badgeImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.white
        return view
    }()

    let badgeLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.backgroundColor = UIColor.clear
        view.font = UIFont.systemFont(ofSize: 13.0)
        view.textColor = UIColor.white
        view.text = "0"
        return view
    }()

    let label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.backgroundColor = UIColor.clear
        view.font = UIFont.systemFont(ofSize: 13.0)
        view.textColor = UIColor.grayColorWithUniversalInt(value: 200)
        view.text = "Item"
        return view
    }()

    let buttonSize: CGFloat = 55.0


    var didSetupConstraints: Bool = false

    func setData(feed: Feed) {
        self.feed = feed

        self.configureText(feed: feed)
        self.configureBadge(feed: feed)

        imageView.image = UIImage.init(named: feed.imageName)
    }

    private func configureText(feed: Feed) {
        self.label.text = feed.text
        var textColor = UIColor.grayColorWithUniversalInt(value: 180)
        switch feed.type {
        case .white:
            textColor = UIColor.grayColorWithUniversalInt(value: 250)
        case .gray:
            textColor = UIColor.grayColorWithUniversalInt(value: 100)
        case .colorful:
            textColor = UIColor.grayColorWithUniversalInt(value: 180)
        }
        self.label.textColor = textColor
    }

    private func configureBadge(feed: Feed) {
        switch feed.type {
        case .white:
            badgeImage.image = UIImage.init(named: "star_black")
            badgeImage.backgroundColor = UIColor.white
            badgeLabel.text = ""
        default :
            badgeImage.image = nil
            if feed.badgeValue > 0 {
                badgeImage.backgroundColor = UIColor.red
                badgeLabel.text = "\(feed.badgeValue)"
            } else {
                badgeLabel.text = ""
                badgeImage.backgroundColor = UIColor.clear
            }
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(bgView)

        self.addSubview(imageView)
        imageView.rounded(radius: buttonSize*0.4)
        self.addSubview(label)
        self.addSubview(badgeImage)
        badgeImage.rounded(radius: buttonSize*0.2)
        self.addSubview(badgeLabel)
        self.backgroundColor = UIColor.yellow
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let feed = feed {
            var colors: [UIColor] = []
            switch feed.type {
            case .colorful:
                colors = [UIColor.AppColors.Yellow,UIColor.AppColors.Purple]
            case .gray:
                colors = [UIColor.AppColors.Gray, UIColor.AppColors.Gray]
            case .white:
                colors = [UIColor.AppColors.White, UIColor.AppColors.White]
            }
            bgView.setBorder(cornerRadius: buttonSize / 2.0, colors: colors, lineWidth: 2, direction: .horizontal)
        }

    }
    override func updateConstraints() {
        super.updateConstraints()

        if !didSetupConstraints {

            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.bounds = CGRect(x: 0.0, y: 0.0, width: 9999.0, height: 9999.0)

            label.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(10.0)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(15.0)
            }

            bgView.snp.remakeConstraints { make in
                make.bottom.equalTo(label.snp.top).offset(-10.0)
                make.left.equalToSuperview().priority(250.0)
                make.right.equalToSuperview().priority(250.0)
                make.centerX.equalToSuperview()
                make.height.equalTo(buttonSize)
                make.width.equalTo(buttonSize)
            }


            imageView.snp.remakeConstraints { make in
                let imageSize = buttonSize * 0.8
                make.center.equalTo(bgView.snp.center)
                make.height.equalTo(imageSize)
                make.width.equalTo(imageSize)
            }

            badgeImage.snp.remakeConstraints { make in
                let imageSize = buttonSize * 0.4
                make.trailing.equalTo(bgView.snp.trailing).inset(-5.0)
                make.top.equalTo(bgView.snp.top)
                make.height.equalTo(imageSize)
                make.width.equalTo(imageSize)
            }

            badgeLabel.snp.remakeConstraints { make in
                make.center.equalTo(badgeImage.snp.center)
                make.height.equalTo(badgeImage.snp.width)
                make.height.equalTo(badgeImage.snp.height)
            }

            didSetupConstraints = true

        }

    }

}



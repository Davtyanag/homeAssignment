//
//  VideoCell.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit
import AVFoundation

class DescriptionCell: BaseCell {

    private var viewsCount: Int = 0
    private var name: String = ""
    private var starsCount: Int = 0
    private var clipDate: Date = Date()

    private var starsIconSize:CGFloat = 15.0

    var topLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor.clear
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        view.numberOfLines = 1
        return view
    }()

    var bottomLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor.clear
        view.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        view.textColor = UIColor.white
        return view
    }()

    var starsButton: HighlighableButton = {
        let view = HighlighableButton()
        let color = UIColor.AppColors.Yellow.withAlphaComponent(0.2)
        view.backgroundColor = color
        view.bgColor = color
        return view
    }()

    var moreButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "dots"), for: .normal)
        view.backgroundColor = UIColor.clear
        return view
    }()

    var starsIcon: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.AppColors.Yellow
        view.image = UIImage.init(named: "star_black")
        return view
    }()

    var starsLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.AppColors.Yellow
        view.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        view.text = "0.0k"
        return view
    }()

    func setText(title: String, viewsCount: Int, name: String, date: Date, starsCount: Int) {
        self.topLabel.text = title
        self.viewsCount = viewsCount
        self.name = name
        self.clipDate = date
        self.starsCount = starsCount
        self.updateBottomLabel()
        self.starsLabel.text = Double(starsCount).kmFormatted
    }

    func updateStarsCount(starsCount: Int) {
        self.starsLabel.text = Double(starsCount).kmFormatted
    }

    private func updateBottomLabel() {

        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.grayColorWithUniversalInt(value: 200)]
        let secondAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]

        let firstString = NSMutableAttributedString(string: "\(Double(viewsCount).kmFormatted) views  ", attributes: firstAttributes)

        let hoursBetweenDates = Int(Date().timeIntervalSince(clipDate) / 3600)
        let nameString = NSAttributedString(string: name, attributes: secondAttributes)
        let thirdString = NSAttributedString(string: " clipped \(hoursBetweenDates)h ago", attributes: firstAttributes)

        firstString.append(nameString)
        firstString.append(thirdString)

        self.bottomLabel.attributedText = firstString
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear

        contentView.addSubview(topLabel)
        contentView.addSubview(bottomLabel)
        contentView.addSubview(starsButton)
        contentView.addSubview(starsIcon)
        contentView.addSubview(starsLabel)
        contentView.addSubview(moreButton)

        starsButton.rounded(radius: 5.0)
        starsIcon.rounded(radius: starsIconSize / 2.0)

        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()

    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func updateConstraints() {
        super.updateConstraints()
        if !didSetupConstraints {
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.bounds = CGRect(x: 0.0, y: 0.0, width: 9999.0, height: 9999.0)


            topLabel.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(0.0)
                make.left.equalToSuperview().inset(20.0)
                make.right.equalTo(moreButton.snp.left).inset(0.0)
                make.height.equalTo(25.0)
            }

            bottomLabel.snp.remakeConstraints { make in
                make.top.equalTo(topLabel.snp.bottom)
                make.left.equalTo(topLabel)
                make.right.equalTo(topLabel)
                make.height.equalTo(topLabel.snp.height)
                make.bottom.equalToSuperview().inset(10.0).priority(999.0)
            }

            starsButton.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().inset(-5.0)
                make.right.equalToSuperview().inset(10.0)
                make.height.equalTo(35.0)
                make.left.equalTo(starsIcon).inset(-10.0)
            }

            starsLabel.snp.remakeConstraints { make in
                make.centerY.equalTo(starsButton.snp.centerY)
                make.right.equalTo(starsButton.snp.right).inset(10.0)
                make.height.equalTo(25.0)
            }

            starsIcon.snp.remakeConstraints { make in
                make.centerY.equalTo(starsButton.snp.centerY)
                make.right.equalTo(starsLabel.snp.left).inset(-5.0)
                make.height.equalTo(starsIconSize)
                make.width.equalTo(starsIconSize)
            }

            moreButton.snp.remakeConstraints { make in
                make.centerY.equalTo(starsButton.snp.centerY)
                make.right.equalTo(starsButton.snp.left).inset(-10.0)
                make.height.equalTo(15.0)
                make.width.equalTo(15.0)
            }

        }
        super.updateConstraints()
    }
}

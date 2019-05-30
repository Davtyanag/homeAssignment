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

    private var starsIconSize:CGFloat {
        return 0.04 * screenSize.width
    }

    var topLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor.clear
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 0.042 * screenSize.width, weight: .semibold)
        view.numberOfLines = 1
        return view
    }()

    var bottomLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor.clear
        view.font = UIFont.systemFont(ofSize: 0.032 * screenSize.width, weight: .regular)
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
        view.font = UIFont.systemFont(ofSize: 0.04 * screenSize.width, weight: .medium)
        view.text = "0.0k"
        return view
    }()

    var charactersCountInsideStarsButton = 0

    func setText(title: String, viewsCount: Int, name: String, date: Date, starsCount: Int) {
        self.topLabel.text = title
        self.viewsCount = viewsCount
        self.name = name
        self.clipDate = date
        self.starsCount = starsCount
        self.updateBottomLabel()
        self.updateStarsCount(starsCount: starsCount)
    }

    func updateStarsCount(starsCount: Int) {
        let text = Double(starsCount).kmFormatted
        self.starsLabel.text = text
        if text.count != charactersCountInsideStarsButton {
            self.didSetupConstraints = false
            charactersCountInsideStarsButton = text.count
            self.setNeedsUpdateConstraints()
            self.updateConstraintsIfNeeded()
        }
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
                make.top.equalToSuperview().inset(screenSize.width * 0.038)
                make.left.equalToSuperview().inset(0.048 * screenSize.width)
                make.right.equalTo(moreButton.snp.left).inset(0.0)
                make.height.equalTo(0.055 * screenSize.width)
            }

            bottomLabel.snp.remakeConstraints { make in
                make.top.equalTo(topLabel.snp.bottom)
                make.left.equalTo(topLabel)
                make.right.equalTo(topLabel)
                make.height.equalTo(topLabel.snp.height)
                make.bottom.equalToSuperview().inset(0.032 * screenSize.width).priority(999.0)
            }

            starsButton.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(0.043 * screenSize.width)
                make.height.equalTo(0.091 * screenSize.width)
                make.left.equalTo(starsIcon).inset(-0.023 * screenSize.width)
            }

            starsLabel.snp.remakeConstraints { make in
                make.centerY.equalTo(starsButton.snp.centerY)
                make.right.equalTo(starsButton.snp.right).inset(0.023 * screenSize.width)
                make.height.equalTo(0.05 * screenSize.width)
            }

            starsIcon.snp.remakeConstraints { make in
                make.centerY.equalTo(starsButton.snp.centerY)
                make.right.equalTo(starsLabel.snp.left).inset(-0.015 * screenSize.width)
                make.height.equalTo(starsIconSize)
                make.width.equalTo(starsIconSize)
            }

            moreButton.snp.remakeConstraints { make in
                make.centerY.equalTo(starsButton.snp.centerY)
                let inset = 0.19 * screenSize.width + CGFloat(charactersCountInsideStarsButton) * 0.023 * screenSize.width
                make.right.equalToSuperview().inset(inset)
                make.height.equalTo(0.043 * screenSize.width)
                make.width.equalTo(0.043 * screenSize.width)
            }

        }
        super.updateConstraints()
    }
}

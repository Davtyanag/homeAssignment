//
//  VideoCell.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit
import AVFoundation

class UserCell: BaseCell {

    private var name: String = ""
    private var followersCount: Int = 0
    private var starsCount: Int = 0
    private var commentsCount: Int = 0
    private var userImage: UIImage?
    private var starsCountToSpend: Int = 0

    private var starsIconSize:CGFloat = 15.0
    private var starsButtonSize: CGFloat {
        return screenSize.width * 0.137
    }
    private var userImageSize: CGFloat {
        return screenSize.width * 0.11
    }
    private let addButtonSize: CGFloat = 20.0
    private var canAnimateStarsButton: Bool = true
    private var stopAnimation: Bool = false

    var userImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.clear
        return view
    }()

    var topLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor.clear
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 0.039 * screenSize.width, weight: .medium)
        view.numberOfLines = 1
        return view
    }()

    var bottomLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor.clear
        view.font = UIFont.systemFont(ofSize: 0.032 * screenSize.width, weight: .regular)
        view.textColor = UIColor.grayColorWithUniversalInt(value: 200)
        return view
    }()

    var starsButton: HighlighableButton = {
        let view = HighlighableButton()
        let color = UIColor.AppColors.Yellow
        view.backgroundColor = color
        view.bgColor = color
        view.setBackgroundImage(UIImage.init(named: "star_white"), for: .normal)
        return view
    }()

    var starsLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.AppColors.Yellow
        view.font = UIFont.systemFont(ofSize: 0.034 * screenSize.width, weight: .regular)
        view.text = "20"
        return view
    }()

    var commentsButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.clear
        return view
    }()

    var commentsIcon: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.clear
        view.contentMode = .scaleToFill
        view.image = UIImage.init(named: "comments")
        return view
    }()

    var commentsLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.grayColorWithUniversalInt(value: 200)
        view.font = UIFont.systemFont(ofSize: 0.032 * screenSize.width, weight: .regular)
        view.text = "0.0k"
        return view
    }()

    var shareButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.clear
        return view
    }()

    var shareIcon: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.clear
        view.contentMode = .scaleToFill
        view.image = UIImage.init(named: "share")
        return view
    }()

    var shareLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.grayColorWithUniversalInt(value: 200)
        view.font = UIFont.systemFont(ofSize: 0.032 * screenSize.width, weight: .regular)
        view.text = "Share"
        return view
    }()

    var verifiedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.clear
        view.setBackgroundImage(UIImage.init(named: "verified"), for: .normal)
        return view
    }()

    var addButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.rgb(r: 111, g: 83, b: 251)
        view.setBackgroundImage(UIImage.init(named: "add"), for: .normal)
        return view
    }()

    weak var delegate: AnimatableButtonDelegate? = nil

    func setText(name: String, followersCount: Int, commentsCount: Int, image: UIImage?, starsCount: Int, starsCountToSpend: Int) {
        self.topLabel.text = name
        self.followersCount = followersCount
        self.name = name
        self.starsCount = starsCount
        self.commentsCount = commentsCount
        self.starsCountToSpend = starsCountToSpend

        self.updateBottomLabel()
        self.starsLabel.text = Double(starsCount).kmFormatted
        self.commentsLabel.text = Double(commentsCount).kmFormatted
        self.topLabel.text = name
        self.userImageView.image = image
    }

    func updateStarsCount(starsCount: Int, starsCountToSpend: Int) {
        self.starsCountToSpend = starsCountToSpend
        self.starsLabel.text = Double(starsCount).kmFormatted
    }

    private func updateBottomLabel() {

        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.grayColorWithUniversalInt(value: 200)]

        let firstString = NSMutableAttributedString(string: "\(Double(followersCount).kmFormatted) Followers", attributes: firstAttributes)

        self.bottomLabel.attributedText = firstString
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear

        contentView.addSubview(userImageView)
        contentView.addSubview(topLabel)
        contentView.addSubview(bottomLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(verifiedButton)

        contentView.addSubview(starsButton)
        contentView.addSubview(starsLabel)

        contentView.addSubview(commentsButton)
        contentView.addSubview(commentsIcon)
        contentView.addSubview(commentsLabel)

        contentView.addSubview(shareButton)
        contentView.addSubview(shareIcon)
        contentView.addSubview(shareLabel)
        

        starsButton.addTarget(self, action: #selector(starsTap), for: .touchUpInside)
        starsButton.rounded(radius: starsButtonSize / 2.0)
        addButton.rounded(radius: addButtonSize / 2.0)
        userImageView.rounded(radius: userImageSize / 2.0)

        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()

    }

    func animateStarsButtonSize() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.2
        animation.fromValue = 1.0
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = false
        animation.repeatCount = 1

        let animationBack = CABasicAnimation(keyPath: "transform.scale")
        animationBack.fromValue = 1.2
        animationBack.toValue = 0.8
        animationBack.duration = 0.2
        animationBack.autoreverses = false
        animationBack.repeatCount = 1
        animationBack.beginTime = 0.2
        animationBack.timingFunction = CAMediaTimingFunction(name: .easeOut)

        let group = CAAnimationGroup.init()
        group.duration = 0.4
        group.animations = [animation, animationBack]

        starsButton.layer.add(group, forKey: "pulsing")
    }

    @objc func starsTap() {
        if canAnimateStarsButton  && !stopAnimation {
            stopAnimation = true
            delay(delay: 0.5) {
                self.stopAnimation = false
            }
            self.animateStarsButtonSize()
        }
        if starsCountToSpend > 0{
            delay(delay: 0.2) {
                self.delegate?.playAnimation()
            }
        }
    }

    func updateCanAnimateButton(canAnimate: Bool) {
        canAnimateStarsButton = canAnimate
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func updateConstraints() {
        super.updateConstraints()
        if !didSetupConstraints {
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.bounds = CGRect(x: 0.0, y: 0.0, width: 9999.0, height: 9999.0)

            userImageView.snp.remakeConstraints { make in
                let topInset = screenSize.width * 0.05
                make.top.equalToSuperview().inset(topInset)
                make.bottom.equalToSuperview().inset(topInset).priority(250.0)
                make.left.equalToSuperview().inset(screenSize.width * 0.038)
                make.height.equalTo(userImageSize)
                make.width.equalTo(userImageSize)
            }

            addButton.snp.remakeConstraints { make in
                make.bottom.equalTo(userImageView.snp.bottom)
                make.right.equalTo(userImageView.snp.right)
                make.height.equalTo(addButtonSize)
                make.width.equalTo(addButtonSize)
            }

            topLabel.snp.remakeConstraints { make in
                make.top.equalTo(userImageView.snp.top).inset(0.008 * screenSize.width)
                make.left.equalTo(userImageView.snp.right).inset(-0.025 * screenSize.width)
                make.height.equalTo(0.042 * screenSize.width)
            }

            verifiedButton.snp.remakeConstraints { make in
                make.centerY.equalTo(topLabel.snp.centerY)
                make.left.equalTo(topLabel.snp.right).inset(-0.022 * screenSize.width)
                make.height.equalTo(0.04 * screenSize.width)
                make.right.lessThanOrEqualTo(shareIcon.snp.left)
                make.width.equalTo(0.04 * screenSize.width)
            }

            bottomLabel.snp.remakeConstraints { make in
                make.top.equalTo(topLabel.snp.bottom).inset(-0.022 * screenSize.width)
                make.left.equalTo(topLabel)
                make.right.equalTo(shareLabel.snp.left)
                make.height.equalTo(topLabel.snp.height)
            }

            starsButton.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(0.017 * screenSize.width)
                make.right.equalToSuperview().inset(0.043 * screenSize.width)
                make.height.equalTo(starsButtonSize)
                make.width.equalTo(starsButtonSize)
            }

            starsLabel.snp.remakeConstraints { make in
                make.centerX.equalTo(starsButton.snp.centerX)
                make.top.equalTo(starsButton.snp.bottom).inset(-0.025 * screenSize.width)
                make.height.equalTo(0.038 * screenSize.width)
            }

            commentsButton.snp.remakeConstraints { make in
                make.centerY.equalTo(starsButton.snp.centerY)
                make.right.equalTo(starsButton.snp.left).inset(-0.04 * screenSize.width)
                make.height.equalTo(1.6 * screenSize.width)
                make.width.equalTo(0.075 * screenSize.width)
            }

            commentsIcon.snp.remakeConstraints { make in
                make.centerY.equalTo(starsButton.snp.centerY).inset(-0.004 * screenSize.width)
                make.centerX.equalTo(commentsButton.snp.centerX)
                make.height.equalTo(0.045 * screenSize.width)
                make.width.equalTo(0.045 * screenSize.width)
            }

            commentsLabel.snp.remakeConstraints { make in
                make.centerY.equalTo(bottomLabel.snp.centerY)
                make.centerX.equalTo(commentsButton.snp.centerX)
                make.height.equalTo(0.038 * screenSize.width)
            }

            shareButton.snp.remakeConstraints { make in
                make.centerY.equalTo(starsButton.snp.centerY)
                make.right.equalTo(commentsButton.snp.left).inset(-0.04 * screenSize.width)
                make.height.equalTo(commentsButton.snp.height)
                make.width.equalTo(commentsButton.snp.width)
            }

            shareIcon.snp.remakeConstraints { make in
                make.centerY.equalTo(commentsIcon.snp.centerY)
                make.centerX.equalTo(shareButton.snp.centerX)
                make.height.equalTo(commentsIcon.snp.height)
                make.width.equalTo(commentsIcon.snp.width)
            }

            shareLabel.snp.remakeConstraints { make in
                make.centerY.equalTo(bottomLabel.snp.centerY)
                make.centerX.equalTo(shareButton.snp.centerX)
                make.height.equalTo(0.038 * screenSize.width)
            }

        }
        super.updateConstraints()
    }
}

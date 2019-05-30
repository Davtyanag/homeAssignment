//
//  TextCell.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit
import SnapKit
import QuartzCore

class TextCell: BaseCell {
    
    public var title = "" {
        didSet {
            self.titleLabel.text = title
        }
    }

    fileprivate let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.medium)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.lineBreakMode = .byCharWrapping
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
        backgroundColor = UIColor.black.withAlphaComponent(0.9)
        selectedBackgroundView = bgColorView

        backgroundColor = UIColor.clear
        layoutMargins = UIEdgeInsets.zero
        separatorInset = UIEdgeInsets.full
        contentView.addSubview(titleLabel)
        setNeedsUpdateConstraints() // bootstrap Auto Layout
        updateConstraintsIfNeeded()


    }

    let supportedSmiles: [String] = [":pepega:", ":pickachu:", ":sword:"]

    func setMessage(message: Message) {
        let nameAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.AppColors.White, .font: UIFont.systemFont(ofSize: 0.038 * screenSize.width, weight: .bold)]
        let textAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.grayColorWithUniversalInt(value: 200), .font: UIFont.systemFont(ofSize: 0.037 * screenSize.width, weight: .regular)]
        let numberAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.AppColors.Yellow]


        let firstString = NSMutableAttributedString(string: message.name + "   ", attributes: nameAttribute)
        let splitedArray = message.text.split(separator: " ")
        var hasAnyTextBeforeSmile: Bool = false
        for string in splitedArray {
            let str = String(string)
            if str.isNumber {
                hasAnyTextBeforeSmile = true
                let space = NSAttributedString(string: " ", attributes: textAttribute)
                firstString.append(space)
                let secondString = NSAttributedString(string: "\(str)", attributes: numberAttribute)
                firstString.append(secondString)
            } else if supportedSmiles.contains(str) {
                if hasAnyTextBeforeSmile {
                    let space = NSAttributedString(string: "  ", attributes: textAttribute)
                    firstString.append(space)
                }
                hasAnyTextBeforeSmile = true
                let imageAttachment = NSTextAttachment()
                let imageSize = 0.06 * screenSize.width
                imageAttachment.bounds = CGRect.init(x: 0, y: -0.015 * screenSize.width, width: imageSize, height: imageSize)
                imageAttachment.image = UIImage(named: str.replacingOccurrences(of: ":", with: ""))
                let image1String = NSAttributedString(attachment: imageAttachment)
                firstString.append(image1String)
            } else {
                hasAnyTextBeforeSmile = true
                let secondString = NSAttributedString(string: " \(str)", attributes: textAttribute)
                firstString.append(secondString)
            }
        }

        self.setAttributedText(text: firstString)
    }

    func setAttributedText(text: NSAttributedString?) {
        titleLabel.text = nil
        titleLabel.attributedText = text
    }

    public func setColor(color: UIColor) {
        titleLabel.textColor = color
    }

    public func setFont(font: UIFont) {
        titleLabel.font = font
    }

    public func setText(text: String) {
        titleLabel.attributedText = nil
        titleLabel.text = text
    }

    func setTextAlignment(alignment: NSTextAlignment) {
        titleLabel.textAlignment = alignment
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateConstraints() {
        super.updateConstraints()
        if !didSetupConstraints {
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.bounds = CGRect(x: 0.0, y: 0.0, width: 99999.0, height: 99999.0)

            titleLabel.setContentHuggingPriority(.required, for: .vertical)
            titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

            titleLabel.snp.remakeConstraints { make in
                make.leading.equalToSuperview().inset(0.048 * screenSize.width)
                make.top.equalToSuperview().inset(0.012 * screenSize.width)
                make.bottom.equalToSuperview().inset(0.0)
                make.trailing.equalToSuperview().inset(0.0)
            }
        }
        super.updateConstraints()
    }
}

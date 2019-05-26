//
//  FeedCell.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit
import Device

class ChatCell: BaseCell  {

    let kTextCell = String.init(describing: TextCell.classForCoder())

    var chatSize: CGFloat {
        switch Device.size() {
        case .screen4Inch:    return 80.0
        case .screen4_7Inch:  return 110.0
        case .screen5_5Inch:  return 110.0
        case .screen5_8Inch:  return 140.0
        case .screen6_1Inch:  return 180.0
        case .screen6_5Inch:  return 180.0
        default:              return 110.0
        }
    }

    var messages: [Message] = []
    let gradientLayerName =  "gradient"

    let tableView: UITableView = {
        let view = UITableView.init(frame: CGRect.zero)
        view.backgroundColor = UIColor.clear
        view.separatorColor = UIColor.clear
        return view
    }()

    let downOverlay: UIView = {
        let view = UIView.init(frame: CGRect.zero)
        view.backgroundColor = UIColor.clear
        return view
    }()

    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        self.removeLayer()
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = gradientLayerName
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = downOverlay.bounds
        downOverlay.layer.insertSublayer(gradientLayer, at: 0)
    }

    func removeLayer() {
        for layer in downOverlay.layer.sublayers ?? [] {
            if layer.name == gradientLayerName {
                layer.removeFromSuperlayer()
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.setGradientBackground(colorTop: UIColor.clear, colorBottom: UIColor.AppColors.Background)
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear

        contentView.addSubview(tableView)
        tableView.registerForCells(cells: [TextCell.classForCoder()])
        tableView.dataSource = self
        tableView.delegate = self


        contentView.addSubview(downOverlay)

        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()

    }

    func setMessages(messages:[Message]) {
        self.messages = messages
        tableView.reloadData()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func updateConstraints() {
        super.updateConstraints()
        if !didSetupConstraints {
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.bounds = CGRect(x: 0.0, y: 0.0, width: 9999.0, height: 9999.0)

            tableView.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(0.0)
                make.bottom.equalToSuperview().priority(999.0)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(chatSize)
            }

            downOverlay.snp.remakeConstraints { make in
                make.bottom.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(25.0)
            }
        }

        delay(delay: 0.3) {
            self.layoutSubviews()
        }

    }
}

extension ChatCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: kTextCell, for: indexPath) as? TextCell) ?? TextCell()
        cell.setMessage(message: messages[indexPath.row])
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets.full
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
        return 100.0
    }

    
}



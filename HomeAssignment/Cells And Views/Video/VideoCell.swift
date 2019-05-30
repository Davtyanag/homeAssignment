//
//  VideoCell.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit
import AVFoundation
import Device

class VideoCell: BaseCell {

    private var player: AVPlayer?
    private var fileName: String = ""
    private var videoAspect: CGFloat  {
        switch Device.size() {
        case .screen4Inch:    return 0.66
        case .screen4_7Inch:  return 0.69
        case .screen5_5Inch:  return 0.69
        case .screen6_1Inch:  return 0.82
        case .screen6_5Inch:  return 0.82
        default:              return 0.8
        }
    }

    private var prizeText: String = ""
    private var entries: Int = 0
    private var videoDuration: Int = 0
    var timer = Timer()


    var playerView: UIView = {
        let view = UIView()
        return view
    }()

    var descriptionBackGround: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(r: 50, g: 61, b: 65).withAlphaComponent(0.85)
        return view
    }()

    var topLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor.clear
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 0.037 * screenSize.width, weight: .semibold)
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

    var chevron: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.clear
        view.contentMode = .scaleAspectFit
        view.image = UIImage.init(named: "chevron")
        return view
    }()

    func play(fileName: String) {
        self.fileName = fileName
        let videoURL = URL(string: fileName)
        player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * videoAspect)
        playerLayer.videoGravity = .resizeAspectFill
        playerView.layer.addSublayer(playerLayer)
        player?.play()

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
    }

    func setText(eventName: String, prizeText: String, entries: Int, initialDuration: Int) {
        self.topLabel.text = eventName
        self.prizeText = prizeText
        self.entries = entries
        self.videoDuration = initialDuration
        self.updateBottomLabel()
        self.scheduleTimerEachSecond()
    }

    func scheduleTimerEachSecond() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }

    @objc func updateCounting(){
        self.videoDuration += 1
        self.updateBottomLabel()
    }

    let numberFormatter = NumberFormatter()


    private func updateBottomLabel() {

        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.AppColors.Yellow, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 0.034 * screenSize.width, weight: .semibold)]
        let secondAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 0.032 * screenSize.width, weight: .regular)]

        let firstString = NSMutableAttributedString(string: prizeText, attributes: firstAttributes)
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds: videoDuration)
        let secondString = NSAttributedString(string: " \(h)h \(m)m \(s)s ", attributes: secondAttributes)
        let formattedNumber = numberFormatter.string(from: NSNumber(value:entries))
        let thirdString = NSAttributedString(string: (formattedNumber ?? "") + " Entries", attributes: secondAttributes)

        firstString.append(secondString)
        firstString.append(thirdString)

        self.bottomLabel.attributedText = firstString
    }

    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        numberFormatter.numberStyle = .decimal
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear

        contentView.addSubview(playerView)
        contentView.addSubview(descriptionBackGround)

        descriptionBackGround.addSubview(topLabel)
        descriptionBackGround.addSubview(bottomLabel)
        descriptionBackGround.addSubview(chevron)

        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()

    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func updateConstraints() {
        super.updateConstraints()
        if !didSetupConstraints {
            let height = UIScreen.main.bounds.width * videoAspect
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.bounds = CGRect(x: 0.0, y: 0.0, width: 9999.0, height: 9999.0)

            playerView.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(0.0)
                make.bottom.equalToSuperview().priority(999.0)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(height)
            }

            descriptionBackGround.snp.remakeConstraints { make in
                make.bottom.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(height * 0.269)
            }

            topLabel.snp.remakeConstraints { make in
                make.top.equalTo(descriptionBackGround).inset(height * 0.04)
                make.left.equalTo(descriptionBackGround).inset(0.048 * screenSize.width)
                make.right.equalTo(descriptionBackGround).inset(0.1 * screenSize.width)
                make.height.equalTo(height * 0.1)
            }

            bottomLabel.snp.remakeConstraints { make in
                make.top.equalTo(topLabel.snp.bottom).inset(height * 0.01)
                make.left.equalTo(topLabel)
                make.right.equalTo(topLabel)
                make.height.equalTo(topLabel.snp.height)
            }

            chevron.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(0.04 * screenSize.width)
                make.height.equalTo(height * 0.05)
                make.width.equalTo(height * 0.05)
            }

        }
        super.updateConstraints()
    }
}

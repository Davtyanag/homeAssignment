//
//  VideoViewController.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit
import QuartzCore

protocol AnimatableButtonDelegate: class {
    func playAnimation()
}

final class VideoViewController: BaseTableViewController, AnimatableButtonDelegate {

    let kFeedCell = String(describing: FeedCell.classForCoder())
    let kVideoCell = String(describing: VideoCell.classForCoder())
    let kDescriptionCell = String(describing: DescriptionCell.classForCoder())
    let kChatCell = String(describing: ChatCell.classForCoder())
    let kUserCell = String(describing: UserCell.classForCoder())

    var starsCountToSpend: Int = 12
    var starsCountAlreadyHave: Int = 10
    var lastDonationSize: Int = 0
    private let pulsingLayerName = "pulsing"
    private let possibleColorsForLabel = [UIColor.red, UIColor.green, UIColor.blue, UIColor.white, UIColor.cyan]

    override func viewDidLoad() {
        super.viewDidLoad()

//        let curvedView = CurvedView(frame: view.frame)
//        curvedView.backgroundColor = .yellow
//
//        view.addSubview(curvedView)
    }

    override func configureTableView() {
        super.configureTableView()
        self.tableView.isScrollEnabled = false
    }

    override func registerCells() {
        tableView.registerForCells(cells: [FeedCell.classForCoder(), VideoCell.classForCoder(), DescriptionCell.classForCoder(), ChatCell.classForCoder(), UserCell.classForCoder()])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let custom = self.tabBarController as? TabBarViewController {
            custom.addRedDotAtTabBarItemIndex(index: 2)
        }
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 5
    }

    private func cellForFeed(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: kFeedCell, for: indexPath) as? FeedCell) ?? FeedCell()
        cell.setFeeds(feeds: getFeeds())
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets.full
        return cell
    }

    private func cellForUser(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: kUserCell, for: indexPath) as? UserCell) ?? UserCell()
        cell.setText(name: "Ninja", followersCount: 89490, commentsCount: 102, image: UIImage.init(named: "feed3"), starsCount: starsCountAlreadyHave, starsCountToSpend: starsCountToSpend)
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets.full
        cell.delegate = self
        return cell
    }

    private func cellForVideo(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: kVideoCell, for: indexPath) as? VideoCell) ?? VideoCell()
        cell.setText(eventName: "#12 in Today's Top Clip Contest", prizeText: "$1k Prize Pool", entries: 1029, initialDuration: 20704)
        cell.play(fileName: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets.full
        return cell
    }

    private func cellForDescription(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: kDescriptionCell, for: indexPath) as? DescriptionCell) ?? DescriptionCell()
        cell.setText(title: "NYC was fun but I'm back!", viewsCount: 32100, name: "Jinjuh", date: Date().dateBySubstructingHours(hours: 5), starsCount: starsCountToSpend)
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets.full
        return cell
    }

    private func cellForChat(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: kChatCell, for: indexPath) as? ChatCell) ?? ChatCell()
        cell.setMessages(messages: getMessages())
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets.full
        return cell
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return cellForFeed(tableView: tableView, indexPath: indexPath)
        case 1:
            return cellForDescription(tableView: tableView, indexPath: indexPath)
        case 2:
            return cellForVideo(tableView: tableView, indexPath: indexPath)
        case 3:
            return cellForChat(tableView: tableView, indexPath: indexPath)
        default:
            return cellForUser(tableView: tableView, indexPath: indexPath)
        }
    }

    func getFeeds() -> [Feed] {
        let feed1 = Feed.init(text: "Feed", imageName: "feed1", badgeValue: 0, type: .colorful)
        let feed2 = Feed.init(text: "$1k Contest", imageName: "feed2", badgeValue: 0, type: .white)
        let feed3 = Feed.init(text: "Ninja", imageName: "feed3", badgeValue: 3, type: .colorful)
        let feed4 = Feed.init(text: "pokimane", imageName: "feed4", badgeValue: 7, type: .gray)
        let feed5 = Feed.init(text: "KingOfKings", imageName: "feed5", badgeValue: 0, type: .gray)
        return [feed1,feed2,feed3,feed4,feed5]
    }

    private func getMessages() -> [Message] {
        let message1 = Message.init(name: "drg5", text: "just liked this 100 times")
        let message2 = Message.init(name: "ninja", text: ":pepega: :pepega: :pepega:")
        let message3 = Message.init(name: "yuierro", text: "how do you even do that? :sword: :sword: :sword:")
        let message4 = Message.init(name: "picachU", text: "im gon try that! :pickachu: :pickachu: :pickachu:")
        let message5 = Message.init(name: "picachU2", text: "im gon try that! :pickachu: :pickachu: :pickachu:")
        let message6 = Message.init(name: "picachU3", text: "im gon try that! :pickachu: :pickachu: :pickachu:")
        return [message1, message2, message3, message4, message5, message6]
    }

    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor, position: CGPoint) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 32, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 20
        layer.fillColor = fillColor.cgColor
        layer.lineCap = .round
        layer.opacity = 0.2
        layer.position = position
        return layer
    }

    private func setupCircleLayer(position: CGPoint) -> CAShapeLayer {
        let layer = createCircleShapeLayer(strokeColor: .clear, fillColor: UIColor.AppColors.Yellow, position: position)
        view.layer.addSublayer(layer)
        return layer
    }

    private func animatePulsatingLayer(layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "transform.scale")

        animation.toValue = 3.5
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = false
        animation.repeatCount = 1

        let animationFade = CABasicAnimation(keyPath: "opacity")
        animationFade.fromValue = 0.2
        animationFade.toValue = 0.6
        animationFade.duration = 0.3
        animationFade.beginTime = 0.2
        animationFade.autoreverses = false
        animationFade.repeatCount = 1
        animationFade.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let animationFadeReverse = CABasicAnimation(keyPath: "opacity")
        animationFadeReverse.fromValue = 0.6
        animationFadeReverse.toValue = 0.2
        animationFadeReverse.duration = 0.3
        animationFadeReverse.beginTime = 0.5
        animationFadeReverse.autoreverses = false
        animationFadeReverse.repeatCount = 1
        animationFadeReverse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let group = CAAnimationGroup.init()
        group.duration = 0.8
        group.animations = [animation, animationFade, animationFadeReverse]
        group.delegate = LayerRemover(for: layer)

        layer.name = pulsingLayerName
        layer.add(group, forKey: pulsingLayerName)
    }

    func playAnimation() {
        if starsCountToSpend > 0 {
            starsCountAlreadyHave += 1
        }
        starsCountToSpend = max(starsCountToSpend - 1, 0)

        let indexPath = IndexPath.init(row: 4, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? UserCell {
            cell.updateStarsCount(starsCount: starsCountAlreadyHave, starsCountToSpend: starsCountToSpend)
            let rectOfCell = tableView.rectForRow(at: indexPath)
            let rectOfCellInSuperview = tableView.convert(rectOfCell, to: self.view)
            let positionCalculated = CGPoint.init(x: rectOfCellInSuperview.origin.x + cell.starsButton.frame.origin.x + cell.starsButton.frame.width / 2.0, y: rectOfCellInSuperview.origin.y + cell.starsButton.frame.height / 2.0 + cell.starsButton.frame.origin.y)
            self.generateAnimatedViews(position: positionCalculated)
            self.animatePulsatingLayer(layer: setupCircleLayer(position: positionCalculated))
        }

        if let cell = tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as? DescriptionCell {
            cell.updateStarsCount(starsCount: starsCountToSpend)
        }
    }
}

extension VideoViewController {

    private func getColorAndSizeForLabel(count: Int) -> (UIColor,Int) {
        let countOfColors = possibleColorsForLabel.count
        return (possibleColorsForLabel[count % countOfColors], 15 + 2*(count % 10))
    }

    private func generateAnimatedViews(position: CGPoint) {
        let layers = view.layer.sublayers ?? []
        if layers.contains(where: { (layer) -> Bool in
            return layer.name == pulsingLayerName
        }) {
            lastDonationSize += 1
        } else {
            lastDonationSize = 1
        }

        let label = UILabel.init()
        let (color, sizeOfFont) = getColorAndSizeForLabel(count: lastDonationSize)
        label.font = UIFont.systemFont(ofSize: CGFloat(sizeOfFont), weight: .semibold)
        label.textColor = color
        label.text = "+\(lastDonationSize)"
        label.frame = CGRect(x: 0, y: 0, width: 80.0, height: 80.0)

        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath(initialPosition: position).cgPath
        animation.duration = 1.0
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        let animationFade = CABasicAnimation(keyPath: "opacity")
        animationFade.fromValue = 1.0
        animationFade.toValue = 0.2
        animationFade.duration = 0.5
        animationFade.beginTime = 0.5
        animationFade.autoreverses = false
        animationFade.repeatCount = 1
        animationFade.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let group = CAAnimationGroup.init()
        group.duration = 1.0
        group.animations = [animation, animationFade]

        label.layer.add(group, forKey: "groupKey")
        view.addSubview(label)
        delay(delay: 0.9) {
            label.removeFromSuperview()
        }
    }
}

func customPath(initialPosition: CGPoint) -> UIBezierPath {
    let path = UIBezierPath()

    path.move(to: CGPoint(x: initialPosition.x, y: initialPosition.y))

    let endPoint = CGPoint(x: initialPosition.x, y: UIScreen.main.bounds.height * 0.2)
    let randValue = drand48()
    let randomXShift: Double = randValue * 200.0
    let cp1 = CGPoint(x: Double(initialPosition.x) - randomXShift, y: Double(UIScreen.main.bounds.height * 0.8))
    let cp2 = CGPoint(x: Double(initialPosition.x) + randomXShift, y: Double(UIScreen.main.bounds.height * 0.7))

    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

class CurvedView: UIView {

    override func draw(_ rect: CGRect) {
        //do some fancy curve drawing
        let path = customPath(initialPosition: CGPoint(x: 350, y: 560))
        path.lineWidth = 3
        path.stroke()
    }

}

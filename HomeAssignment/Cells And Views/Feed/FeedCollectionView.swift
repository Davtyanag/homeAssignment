//
//  FeedCollectionView.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//


import UIKit


protocol FeedCollectionViewDelegate: class {
    func didSelectFeed(index:Int)
}

class FeedCollectionView: UICollectionView {

    var spacingSizeFromSides: CGFloat {
        return screenSize.width * 0.1
    }

    private var feeds:[Feed] = []

    weak var feedDelegate: FeedCollectionViewDelegate?

    let kFeedItem = String.init(describing: FeedItem.classForCoder())

    var itemSizes = [CGSize]()
    var textSizes = [CGFloat]()

    init(frame: CGRect) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .clear

        self.dataSource = self
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.register(FeedItem.classForCoder(), forCellWithReuseIdentifier: kFeedItem)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setData(feeds:[Feed]) {
        self.feeds = feeds
        self.calculateItemsWidth()
        self.collectionViewLayout.invalidateLayout()
        self.reloadData()
    }

    private func calculateTextSizes() {
        self.textSizes = []
        for feed in feeds {
            let fontAttributes: [NSAttributedString.Key : Any]  = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: FeedItem.fontSize)]
            self.textSizes.append(widthForFeed(feed: feed, attributes: fontAttributes))
        }
    }

    private func calculateMaxInset() -> CGFloat {
        var maxInset: CGFloat = 0.0
        let buttonSize =  FeedItem.buttonWithBadgeSize
        let defaultLeftOrRight = 0.016 * screenSize.width
        var leftInset: CGFloat = defaultLeftOrRight
        var rightInset: CGFloat = leftInset
        let textSizesCount = textSizes.count
        for (index,size) in textSizes.enumerated() {
            if index != textSizesCount - 1 {
                rightInset = (size - buttonSize) / 2.0
                leftInset = (textSizes[index + 1] - buttonSize) / 2.0
                let sum = rightInset + leftInset
                maxInset = max(maxInset, sum)
            }
        }
        return maxInset
    }

    private func calculateItemsWidth() {
        self.itemSizes = []
        calculateTextSizes()
        let feedsCount = feeds.count
        let buttonSize = FeedItem.buttonWithBadgeSize
        let totalInset = calculateMaxInset()
        let height = 0.22 * screenSize.width
        for (index, _) in feeds.enumerated() {
            let widthForCurrent = textSizes[index]
            let currentInsets = (widthForCurrent - buttonSize) / 2.0
            var sumOfSides: CGFloat = 0.0
            if index < feedsCount - 1 {
                let widthForNext = textSizes[index + 1]
                let insetFromNext = (widthForNext - buttonSize) / 2.0
                var insetFromPrevious:CGFloat = 0.0
                if index > 0 {
                    let widthForPrevious = itemSizes[index - 1].width
                    insetFromPrevious = (widthForPrevious - buttonSize) / 2.0
                }
                if insetFromNext >= currentInsets || insetFromPrevious >= currentInsets {
                    sumOfSides = max((totalInset - max(insetFromNext,insetFromPrevious)) * 2, 0.0)
                } else {
                    let dif = max(totalInset - insetFromPrevious - currentInsets, 0)
                    itemSizes.append(CGSize.init(width: textSizes[index] + 2*dif, height: height))
                    continue
                }
            } else {
                let widthForPrevious = itemSizes[index - 1].width
                let insetFromPrevious = (widthForPrevious - buttonSize) / 2.0
                sumOfSides = max((totalInset - insetFromPrevious) * 2, textSizes[index] - buttonSize)
            }

            itemSizes.append(CGSize.init(width: sumOfSides + buttonSize, height: height))

        }
    }

    private func widthForFeed(feed: Feed, attributes: [NSAttributedString.Key:Any]) -> CGFloat {
        let buttonSize =  FeedItem.buttonWithBadgeSize
        let myText = feed.text
        let size = (myText as NSString).size(withAttributes: attributes)
        return max(size.width * 1.1, buttonSize)
    }

}

extension FeedCollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func makeMenuAction(indexPathValue: Int) {
         debugPrint("indexPathValue index",indexPathValue)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.makeMenuAction(indexPathValue: indexPath.item)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = 0.03 * screenSize.width
        return UIEdgeInsets.init(top: 0.0, left: inset, bottom: 0.0, right: inset)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

}

extension FeedCollectionView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feeds.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSizes[indexPath.item]
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: kFeedItem, for: indexPath) as? FeedItem) ?? FeedItem()
        cell.setData(feed: feeds[indexPath.item])

        cell.backgroundColor = .clear
        return cell

    }

}




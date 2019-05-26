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

    let spacingSize:CGFloat = 20.0

    private var feeds:[Feed] = []

    weak var feedDelegate: FeedCollectionViewDelegate?

    let kFeedItem = String.init(describing: FeedItem.classForCoder())

    init(frame: CGRect) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = spacingSize
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        layout.itemSize =  UICollectionViewFlowLayout.automaticSize
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
        return UIEdgeInsets.init(top: 0.0, left: spacingSize, bottom: 0.0, right: spacingSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacingSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacingSize
    }


    

//    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellize = 100.0
//        return CGSize(width: cellize, height: cellize)
//    }

}

extension FeedCollectionView: UICollectionViewDataSource {

    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feeds.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: kFeedItem, for: indexPath) as? FeedItem) ?? FeedItem()
        cell.setData(feed: feeds[indexPath.item])

        cell.backgroundColor = .clear
        return cell

    }

}




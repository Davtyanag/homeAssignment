//
//  TabBarViewController.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {


    enum TabBarType: String {
        case video
        case search
        case notifications
        case profile
        case none
    }

    let dotTag = 1302

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.addViewControllers()
    }

    private func addViewControllers() {
        self.viewControllers = [viewControllerForTab(type: .video), viewControllerForTab(type: .search), viewControllerForTab(type: .notifications), viewControllerForTab(type: .profile)]
        self.tabBarController(self, didSelect: self.viewControllers![2])
    }

    private func viewControllerForTab(type: TabBarType) -> BaseTableViewController {
        let viewController = type == .video ? VideoViewController() : BaseTableViewController()
        viewController.view.backgroundColor = UIColor.AppColors.Background

        let imageInsetSize:CGFloat = 5.0
        let image = UIImage(named: type.rawValue)
        let tabBarItem = UITabBarItem.init(title: nil, image: image, selectedImage: image)
        tabBarItem.imageInsets = UIEdgeInsets(top: imageInsetSize, left: 0, bottom: -imageInsetSize, right: 0)
        viewController.tabBarItem = tabBarItem
        viewController.tabBarType = type
        return viewController
    }

    func addRedDotAtTabBarItemIndex(index: Int) {
        removeRedDotAtTabBarItemIndex(index: index)

        let redDotRadius: CGFloat = 3
        let redDotDiameter = redDotRadius * 2
        let topMargin:CGFloat = 13

        guard let items = tabBar.items else {
            return
        }

        let tabBarItemCount = CGFloat(items.count)
        let halfItemWidth = view.bounds.width / (tabBarItemCount * 2)
        let xOffset = halfItemWidth * CGFloat(index * 2 + 1) - 2.0
        let imageHalfWidth: CGFloat = (items[index].selectedImage?.size.width ?? 0) / 2

        let redDot = UIView(frame: CGRect(x: xOffset + imageHalfWidth, y: topMargin, width: redDotDiameter, height: redDotDiameter))

        redDot.tag = dotTag
        redDot.backgroundColor = UIColor.red
        redDot.layer.cornerRadius = redDotRadius

        self.tabBar.addSubview(redDot)
    }

    func removeRedDotAtTabBarItemIndex(index: Int) {
        for subview in self.tabBar.subviews {
            if subview.tag == dotTag {
                subview.removeFromSuperview()
                break
            }
        }
    }
}

extension TabBarViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let vc = (viewController as? BaseTableViewController) {
            if vc.tabBarType != .notifications {
                self.addRedDotAtTabBarItemIndex(index: 2)
            } else {
                self.removeRedDotAtTabBarItemIndex(index: 2)
            }
        }
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
}

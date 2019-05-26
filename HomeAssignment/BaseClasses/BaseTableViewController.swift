//
//  BaseTableViewController.swift
//  HomeAssignment
//
//  Created by Арман Давтян on 5/25/19.
//  Copyright © 2019 Arman Davtyan. All rights reserved.
//

import UIKit
import SnapKit

class BaseTableViewController: UIViewController {

    var tabBarType: TabBarViewController.TabBarType = .none
    var tableView: UITableView!
    var didSetupConstraints = false

    func type() -> UITableView.Style {
        return .plain
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppColors.Background
        registerCells()
        configureTableView()
    }

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func configureTableView() {}

    func registerCells() {}

    public override func loadView() {
        super.loadView()
        setupTableView()
    }

    func setupTableView() {
        tableView = UITableView(frame: CGRect.zero, style: type())
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.sectionHeaderHeight = 0.0
        tableView.sectionFooterHeight = 0.0
        tableView.separatorColor = UIColor.darkGray.withAlphaComponent(0.8)
        tableView.keyboardDismissMode = .onDrag
        view.addSubview(tableView)
        view.setNeedsUpdateConstraints()
    }

    public override func updateViewConstraints() {
        super.updateViewConstraints()
        didSetupConstraints = false
        if !didSetupConstraints {
            tableView.snp.remakeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }

            didSetupConstraints = true
        }
    }
}

extension BaseTableViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BaseTableViewController: UITableViewDataSource {
    public func tableView(_: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.AppColors.Background
        cell.backgroundView = UIView()
        return cell
    }

    public func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 10
    }

    public func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
        return 100.0
    }
}



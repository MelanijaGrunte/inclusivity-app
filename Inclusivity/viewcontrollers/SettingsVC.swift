//
//  SettingsDialogVC.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 09/05/2020.
//  Copyright © 2020 makit. All rights reserved.
//

import UIKit
import Anchorage

// swiftlint:disable force_cast
public class SettingsDialogVC: UIViewController {
    private let headerView: UIView = {
        let view = UIView()
        view.accessibilityLabel = "Header"
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.accessibilityLabel = "Back"
        button.setImage(UIImage(named: "arrow-back"), for: .normal)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityLabel = "Settings"
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Inclusivity iestatījumi"
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.accessibilityLabel = "Settings"
        tableView.backgroundColor = UIColor.clear
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private var tableViewSections: [DisabilitySection] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableViewSections = DisabilitySection.allCases
                
        layoutViews()
    }
    
    @objc func navigateBack(tap: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Settings Dialog Dismissed"), object: nil)
        })
    }
    
    private func layoutViews() {
        view.backgroundColor = UIColor.white

        view.addSubview(headerView) {
            $0.leftAnchor == $1.leftAnchor + 10
            $0.topAnchor == $1.topAnchor + 4
            $0.rightAnchor == $1.rightAnchor - 10
            $0.heightAnchor == 100
        }
        
        headerView.addSubview(backButton) {
            $0.leftAnchor == $1.leftAnchor
            $0.centerYAnchor == $1.centerYAnchor
            $0.heightAnchor == 50
            $0.widthAnchor == 50
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingsDialogVC.navigateBack(tap:)))
        backButton.addGestureRecognizer(tap)
        
        headerView.addSubview(titleLabel) {
            $0.leftAnchor == backButton.rightAnchor + 10
            $0.rightAnchor == $1.rightAnchor - 60
            $0.centerXAnchor == view.centerXAnchor
            $0.topAnchor == backButton.topAnchor + 15
        }
        
        view.addSubview(tableView) {
            $0.leftAnchor == $1.leftAnchor
            $0.rightAnchor == $1.rightAnchor
            $0.topAnchor == headerView.bottomAnchor
            $0.bottomAnchor == $1.bottomAnchor
        }
    }
}

extension SettingsDialogVC: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        tableViewSections.count
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = SettingsTableViewSection()
        sectionView.title = tableViewSections[section].title
        
        return sectionView
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewItem = tableViewSections[indexPath.section].cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as! SettingsTableViewCell
        cell.isUserInteractionEnabled = tableViewItem.implemented
        cell.type = tableViewItem
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewSections[section].cells.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !tableViewSections[indexPath.section].cells[indexPath.row].details.isEmpty else { return }
        let vc = SettingsDetailsVC()
        vc.type = tableViewSections[indexPath.section].cells[indexPath.row]
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}

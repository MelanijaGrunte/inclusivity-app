//
//  SettingsTableViewCell.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 20/05/2020.
//  Copyright © 2020 makit. All rights reserved.
//

import UIKit
import Anchorage

public class SettingsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SettingsTableViewCell"
    static let leftMargin: CGFloat = 24
    static let rightMargin: CGFloat = -24
    
    private let holderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.tintColor = UIColor.white
        label.font = label.font.withSize(16)
        return label
    }()
    
    private let uiSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isHidden = true
        return uiSwitch
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = label.font.withSize(15)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "chevron-right")
        return imageView
    }()
    
    public var type: DisabilityCell! {
        didSet {
            let isEnabled = UserDefaults.standard.bool(forKey: type.rawValue)
            backgroundColor = type.implemented ? UIColor.white : UIColor.lightGray.withAlphaComponent(0.1)
            titleLabel.textColor = type.implemented ? UIColor.black : UIColor.gray
            titleLabel.text = type.description
            uiSwitch.isOn = isEnabled
            uiSwitch.isHidden = !type.details.isEmpty || !type.implemented
            statusLabel.isHidden = type.details.isEmpty
            chevronImageView.isHidden = type.details.isEmpty
            statusLabel.text = isEnabled ? "Ieslēgts" : "Izslēgts"
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        selectionStyle = .none
        
        addSubview(holderView) {
            $0.leftAnchor == self.leftAnchor + 10
            $0.topAnchor == self.topAnchor + 4
            $0.rightAnchor == self.rightAnchor - 10
            $0.bottomAnchor == self.bottomAnchor - 4
        }
        
        holderView.addSubview(titleLabel) {
            $0.centerYAnchor == $1.centerYAnchor
            $0.leftAnchor == $1.leftAnchor + 16
        }
        
        holderView.addSubview(uiSwitch) {
            $0.centerYAnchor == $1.centerYAnchor
            $0.rightAnchor == $1.rightAnchor - 16
        }
        uiSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        holderView.addSubview(chevronImageView) {
            $0.centerYAnchor == $1.centerYAnchor
            $0.rightAnchor == $1.rightAnchor - 1
            $0.heightAnchor == 30
            $0.widthAnchor == 30
        }
        
        holderView.addSubview(statusLabel) {
            $0.centerYAnchor == $1.centerYAnchor
            $0.rightAnchor == chevronImageView.leftAnchor
        }
    }
    
    @objc func switchValueChanged(_ view: UISwitch) {
        UserDefaults.standard.set(uiSwitch.isOn, forKey: type.rawValue)
    }
}

//
//  SwitchView.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 20/05/2020.
//  Copyright © 2020 makit. All rights reserved.
//

import Foundation
import UIKit
import Anchorage

public class SwitchView: UIView {
    private let holderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let uiSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        return uiSwitch
    }()
    
    public var type: DisabilityCell! {
        didSet {
            let value = UserDefaults.standard.bool(forKey: type.rawValue)
            isOn = value
        }
    }
    
    private var isOn: Bool = false {
        didSet {
            uiSwitch.isOn = isOn
            titleLabel.text = isOn ? "Ieslēgts" : "Izslēgts"
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        backgroundColor = UIColor.clear

        self.addSubview(holderView) {
            $0.leftAnchor == $1.leftAnchor + 10
            $0.topAnchor == $1.topAnchor + 10
            $0.rightAnchor == $1.rightAnchor - 10
            $0.bottomAnchor == $1.bottomAnchor - 10
        }
        
        holderView.addSubview(titleLabel) {
            $0.leftAnchor == $1.leftAnchor + 10
            $0.rightAnchor == $1.rightAnchor - 10
            $0.centerYAnchor == $1.centerYAnchor
        }
        
        holderView.addSubview(uiSwitch) {
            $0.centerYAnchor == $1.centerYAnchor
            $0.rightAnchor == $1.rightAnchor - 16
        }
        uiSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: UIControl.Event.valueChanged)

    }
    
    @objc func switchValueChanged(_ switch: UISwitch) {
        isOn = uiSwitch.isOn
        UserDefaults.standard.set(isOn, forKey: type.rawValue)
    }
}

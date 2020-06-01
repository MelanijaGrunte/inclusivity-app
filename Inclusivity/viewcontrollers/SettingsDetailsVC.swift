//
//  SettingsDetailsVC.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 20/05/2020.
//  Copyright © 2020 makit. All rights reserved.
//

import UIKit
import Anchorage

// swiftlint:disable force_cast
public class SettingsDetailsVC: UIViewController {
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
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.accessibilityLabel = "Settings"
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    public var type: DisabilityCell! {
        didSet {
            titleLabel.text = type.description
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        layoutViews()
    }
    
    @objc func navigateBack(tap: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func layoutViews() {
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
        
        view.addSubview(stackView) {
            $0.leftAnchor == $1.leftAnchor + 10
            $0.rightAnchor == $1.rightAnchor - 10
            $0.topAnchor == headerView.bottomAnchor
        }
        
        let switchView = SwitchView()
        switchView.heightAnchor == 75
        switchView.type = type
        stackView.addArrangedSubview(switchView)

        type.details.filter { $0.configType == .slider_percentage || $0.configType == .slider_count_0_to_5 }.forEach { detail in
            let sliderView = SliderView()
            sliderView.heightAnchor == 150
            sliderView.type = detail
            stackView.addArrangedSubview(sliderView)
        }
        
        let oneOfs = type.details.filter { $0.configType == .one_of }
        if !oneOfs.isEmpty {
            let pickerView = PickerView()
            pickerView.heightAnchor == 250
            pickerView.types = oneOfs
            stackView.addArrangedSubview(pickerView)
        }
    }
}

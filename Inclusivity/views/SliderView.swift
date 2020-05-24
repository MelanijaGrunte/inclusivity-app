//
//  SliderView.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 20/05/2020.
//  Copyright © 2020 makit. All rights reserved.
//

import Foundation
import UIKit
import Anchorage

public class SliderView: UIView {
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
    
    private let uiSlider: UISlider = {
        let uiSlider = UISlider()
        uiSlider.accessibilityLabel = "Value setting"
        uiSlider.maximumValue = 100
        uiSlider.minimumValue = 0
        return uiSlider
    }()
    
    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.accessibilityLabel = "Value setting"
        stepper.maximumValue = 100.0
        stepper.minimumValue = 0.0
        stepper.stepValue = 1
        return stepper
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    public var type: DisabilityDetail! {
        didSet {
            titleLabel.text = type.description
            let value = UserDefaults.standard.integer(forKey: type.rawValue)
            uiSlider.maximumValue = (type.configType == .slider_percentage) ? 100 : 5
            stepper.maximumValue = (type.configType == .slider_percentage) ? 100 : 5
            percentage = value
        }
    }
    
    private var percentage: Int = 0 {
        didSet {
            uiSlider.value = Float(percentage)
            stepper.value = Double(percentage)
            valueLabel.text = "\(percentage)%"
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func sliderValueChanged(_ slider: UISlider) {
        percentage = Int(uiSlider.value.rounded())
        valueLabel.text = "\(percentage)%"
        UserDefaults.standard.set(percentage, forKey: type.rawValue)
    }
    
    @objc func stepperValueChanged(_ stepper: UIStepper) {
        percentage = Int(stepper.value.rounded())
        valueLabel.text = "\(percentage)%"
        UserDefaults.standard.set(percentage, forKey: type.rawValue)
    }

    private func setup() {
        backgroundColor = UIColor.white

        self.addSubview(holderView) {
            $0.leftAnchor == $1.leftAnchor + 10
            $0.topAnchor == $1.topAnchor + 10
            $0.rightAnchor == $1.rightAnchor - 10
            $0.bottomAnchor == $1.bottomAnchor - 10
        }
        
        holderView.addSubview(titleLabel) {
            $0.leftAnchor == $1.leftAnchor + 10
            $0.rightAnchor == $1.rightAnchor - 10
            $0.topAnchor == $1.topAnchor + 20
        }
        
        holderView.addSubview(uiSlider) {
            $0.leftAnchor == $1.leftAnchor + 10
            $0.rightAnchor == $1.rightAnchor - 10
            $0.topAnchor == titleLabel.bottomAnchor + 10
        }
        uiSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        holderView.addSubview(stepper) {
            $0.rightAnchor == $1.rightAnchor - 16
            $0.topAnchor == uiSlider.bottomAnchor + 15
        }
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        holderView.addSubview(valueLabel) {
            $0.rightAnchor == stepper.leftAnchor - 15
            $0.centerYAnchor == stepper.centerYAnchor
        }
    }
}

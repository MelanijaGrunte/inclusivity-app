//
//  FirstTestVC.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 05/08/2019.
//  Copyright © 2019 makit. All rights reserved.
//

import UIKit
import Anchorage

// swiftlint:disable:next type_body_length
public class FirstTestVC: TestBaseViewController {
    private let exampleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "dog")
        return imageView
    }()
    
    private let exampleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        // swiftlint:disable:next line_length
        titleLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private let basicButton: UIButton = {
        let basicButton = UIButton()
        basicButton.setTitle(NSLocalizedString("Spiest pogu", comment: ""), for: .normal)
        basicButton.backgroundColor = UIColor.red
        basicButton.setTitleColor(UIColor.white, for: .normal)
        return basicButton
    }()
    
    private let exampleSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        return uiSwitch
    }()
    
    private let exampleSlider: UISlider = {
        let uiSlider = UISlider()
        uiSlider.maximumValue = 100
        uiSlider.minimumValue = 0
        return uiSlider
    }()
    
    private let exampleStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 100.0
        stepper.minimumValue = 0.0
        stepper.stepValue = 1
        return stepper
    }()
    
    private let exampleTextField: UITextField = {
        let textfield = UITextField()
        textfield.text = "Piña Colada"
        return textfield
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        view.bringSubviewToFront(bubbleButton)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.red
        
        view.addSubview(exampleImageView) {
            $0.topAnchor == $1.topAnchor + 100
            $0.leftAnchor == $1.leftAnchor + 30
            $0.rightAnchor == $1.rightAnchor - 30
            $0.heightAnchor == 100
        }
        
        view.addSubview(exampleLabel) {
            $0.topAnchor == exampleImageView.bottomAnchor + 25
            $0.leftAnchor == $1.leftAnchor + 30
            $0.rightAnchor == $1.rightAnchor - 20
        }
        
        view.addSubview(basicButton) {
            $0.heightAnchor == 50
            $0.leftAnchor == $1.leftAnchor + 30
            $0.rightAnchor == $1.rightAnchor - 30
            $0.bottomAnchor == $1.safeAreaLayoutGuide.bottomAnchor - 30
        }
        
        view.addSubview(exampleSwitch) {
            $0.bottomAnchor == exampleImageView.topAnchor - 20
            $0.centerXAnchor == exampleImageView.centerXAnchor
        }
        
        view.addSubview(exampleTextField) {
            $0.topAnchor == exampleImageView.topAnchor + 10
            $0.leftAnchor == $1.leftAnchor + 10
        }
        
        view.addSubview(exampleStepper) {
            $0.bottomAnchor == exampleImageView.bottomAnchor - 10
            $0.leftAnchor == $1.leftAnchor + 10
            $0.rightAnchor == exampleImageView.leftAnchor - 10
        }
        
        view.addSubview(exampleSlider) {
            $0.centerYAnchor == exampleSwitch.centerYAnchor
            $0.leftAnchor == $1.leftAnchor + 10
            $0.rightAnchor == exampleSwitch.leftAnchor - 10
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleBasicButtonTap))
        basicButton.addGestureRecognizer(tap)
    }
    
    @objc private func handleBasicButtonTap() {
        basicButton.backgroundColor = UIColor.random()
    }
}

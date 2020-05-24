//
//  SecondTestVC.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 05/08/2019.
//  Copyright © 2019 makit. All rights reserved.
//

import UIKit
import Anchorage

public class SecondTestVC: TestBaseViewController {
    private let exampleButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Spiest pogu", comment: ""), for: .normal)
        button.backgroundColor = UIColor.green
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    private let exampleSlider: UISlider = {
        let slider = UISlider()
        return slider
    }()
    
    private let exampleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "dog")
        return imageView
    }()
    
    private let exampleDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        return datePicker
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
                
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(exampleImageView) {
            $0.topAnchor == $1.topAnchor + 100
            $0.leftAnchor == $1.leftAnchor + 30
            $0.rightAnchor == $1.rightAnchor - 30
            $0.heightAnchor == 100
        }
        
        view.addSubview(exampleSlider) {
            $0.topAnchor == exampleImageView.bottomAnchor + 25
            $0.leftAnchor == $1.leftAnchor + 30
            $0.rightAnchor == $1.rightAnchor - 20
        }
        
        view.addSubview(exampleDatePicker) {
            $0.topAnchor == exampleSlider.bottomAnchor + 25
            $0.leftAnchor == $1.leftAnchor + 30
            $0.rightAnchor == $1.rightAnchor - 20
        }
        
        view.addSubview(exampleButton) {
            $0.heightAnchor == 50
            $0.leftAnchor == $1.leftAnchor + 30
            $0.rightAnchor == $1.rightAnchor - 30
            $0.bottomAnchor == $1.safeAreaLayoutGuide.bottomAnchor - 30
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        exampleButton.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        exampleButton.backgroundColor = UIColor.random()
    }
}

//
//  PickerView.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 21/05/2020.
//  Copyright © 2020 makit. All rights reserved.
//

import Foundation
import UIKit
import Anchorage

public class PickerView: UIView {
    private let holderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.accessibilityLabel = "Options"
        return pickerView
    }()
    
    public var types: [DisabilityDetail] = [] {
        didSet {
            if let chosenType = types.first(where: { UserDefaults.standard.bool(forKey: $0.rawValue) }), let index = types.firstIndex(of: chosenType) {
                pickerView.selectRow(index, inComponent: 0, animated: true)
            } else {
                pickerView.selectRow(0, inComponent: 0, animated: true)
                saveChoice(types[0])
            }
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
        
        holderView.addSubview(pickerView) {
            $0.leftAnchor == $1.leftAnchor + 10
            $0.topAnchor == $1.topAnchor + 10
            $0.rightAnchor == $1.rightAnchor - 10
            $0.bottomAnchor == $1.bottomAnchor - 10
        }
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func saveChoice(_ type: DisabilityDetail) {
        UserDefaults.standard.set(true, forKey: type.rawValue)
        types.filter { $0 != type }.forEach { UserDefaults.standard.set(false, forKey: $0.rawValue) }
    }
}

extension PickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        types.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        saveChoice(types[row])
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let type = types[row]
        return type.description
    }
}

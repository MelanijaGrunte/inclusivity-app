//
//  Anchorage.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 21/05/2020.
//  Copyright © 2020 ajinalem. All rights reserved.
//

func with<T>(_ object: T?, block: (T) -> Void) {
    object.map(block)
}

func apply<T>(_ object: T, block: (T) -> Void) -> T {
    block(object)
    return object
}

import UIKit
import Anchorage

extension UIView {
    public func addSubviewWithInsets(_ view: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(insets.top))-[view]-(\(insets.bottom))-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": view]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(insets.left))-[view]-(\(insets.right))-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": view]))
    }
    
    public func addSubview(_ view: UIView, block: (_ child: UIView, _ parent: UIView) -> Void) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        block(view, self)
    }
    
    public func addSubview(_ view: UIView, block: (_ child: UIView) -> Void) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        block(view)
    }
    
    public func insertSubview(_ view: UIView, belowSubview siblingSubview: UIView, block: (_ child: UIView, _ parent: UIView) -> Void) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(view, belowSubview: siblingSubview)
        
        block(view, self)
    }
    
    public func centerX(below: UIView, above: UIView) {
        let spaceTop = UILayoutGuide()
        self.addLayoutGuide(spaceTop)
        spaceTop.topAnchor == below.bottomAnchor
        spaceTop.bottomAnchor == self.topAnchor
        
        let spaceBottom = UILayoutGuide()
        self.addLayoutGuide(spaceBottom)
        spaceBottom.topAnchor == self.bottomAnchor
        spaceBottom.bottomAnchor == above.topAnchor
        
        spaceTop.heightAnchor == spaceBottom.heightAnchor
    }
}

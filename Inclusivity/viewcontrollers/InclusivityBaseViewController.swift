//
//  InclusivityBaseViewController.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 21/05/2020.
//  Copyright © 2020 makit. All rights reserved.
//

import Foundation
import UIKit
import Anchorage
import AVFoundation
import MediaPlayer

public class InclusivityBaseViewController: UIViewController {
    
    // MARK: Override functions
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.refresh),
            name: Notification.Name("Settings Dialog Dismissed"),
            object: nil)
    }
    
    @objc private func refresh(notification: NSNotification){
        self.removeEffects()
        self.addEffects()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addBubbleButton()
        addEffects()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        bubbleButton.removeFromSuperview()
        removeEffects()
    }
    
    // MARK: Bubble button
    
    private var bubbleCenter: CGPoint = .zero
    
    public let bubbleButton: UIButton = {
        let bubbleButton = UIButton()
        bubbleButton.setImage(UIImage(named: "app-icon"), for: .normal)
        bubbleButton.accessibilityLabel = "Navigation to settings"
        bubbleButton.layer.cornerRadius = 30  // image.frame.size.width / 2
        bubbleButton.layer.shadowColor = UIColor.black.cgColor
        bubbleButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        bubbleButton.layer.shadowRadius = 3
        bubbleButton.layer.shadowOpacity = 0.5
        return bubbleButton
    }()
    
    @objc func panBubble(pan: UIPanGestureRecognizer) {
        if pan.state == .began {
            bubbleCenter = bubbleButton.center
        } else if pan.state == .ended || pan.state == .failed || pan.state == .cancelled {
            if let newAnchor = pan.view?.centerAnchors {
                bubbleButton.centerAnchors == newAnchor
            }
        } else {
            let location = pan.location(in: view)
            bubbleButton.center = location
        }
    }
    
    @objc func tapBubble(tap: UITapGestureRecognizer) {
        let vc = SettingsDialogVC()
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    private func addBubbleButton() {
        view.addSubview(bubbleButton) {
            $0.heightAnchor == 60
            $0.widthAnchor == 60
            $0.center = view.center
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBubble(tap:)))
        bubbleButton.addGestureRecognizer(tap)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panBubble(pan:)))
        bubbleButton.addGestureRecognizer(pan)
    }
    
    // MARK: Effects setup
    
    private func addEffects() {
        bubbleButton.isHidden = true
        
        addBlur()
        duplicateViews()
        addFloaters()
        addCataracts()
        addColorDeficiency()
        addDiabeticRetinopathy()
        addRetinalDetachment(horizontalMode: true, diagonalMode: true)
        addHemianopia()
        
        removeGestureRecogznizers()
        
        animateFocusDifficulties()
        manipulateKeyboard()
        
        bubbleButton.isHidden = false
        view.bringSubviewToFront(bubbleButton)
    }
    
    private var viewsToRemove: [UIView] = []
    private var layersToRemove: [CALayer] = []
    
    private func removeEffects() {
        viewsToRemove.forEach { view in
            view.removeFromSuperview()
        }
        layersToRemove.forEach { layer in
            layer.removeFromSuperlayer()
        }
    }
    
    // MARK: Blur effect
    
    let blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.effect = UIBlurEffect(style: .regular)
        return blurView
    }()
    
    private func addBlur() {
        guard UserDefaults.standard.bool(forKey: DisabilityCell.blur.rawValue) else { return }
        
        let newImageView = UIImageView()
        view.addSubview(newImageView) {
            $0.topAnchor == view.topAnchor
            $0.bottomAnchor == view.bottomAnchor
            $0.rightAnchor == view.rightAnchor
            $0.leftAnchor == view.leftAnchor
        }
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        let context = CIContext(options: nil)
        
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        
        let beginImage = CIImage(image: image)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(5, forKey: kCIInputRadiusKey)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
        
        let output = cropFilter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        newImageView.image = processedImage
        
        newImageView.isUserInteractionEnabled = false
        viewsToRemove.append(newImageView)
    }
    
    // MARK: Ghosting effect
    
    private func duplicateViews() {
        guard UserDefaults.standard.bool(forKey: DisabilityCell.ghosting.rawValue) else { return }
        
        // šo izsaukt, kad palaiž viewDidLayoutSubviews (ĶIP KAD KKAS MAINĀS)
        view.subviews.forEach { subview in
            guard subview != bubbleButton else { return }
            let newView = subview.copyView()
            view.addSubview(newView) {
                $0.topAnchor == subview.topAnchor + 2
                $0.leftAnchor == subview.leftAnchor + 20
                $0.rightAnchor == subview.rightAnchor + 20
                $0.bottomAnchor == subview.bottomAnchor + 2
            }
            
            newView.isHidden = false
            newView.isUserInteractionEnabled = false
            
            let alpha = Float(UserDefaults.standard.integer(forKey: DisabilityDetail.ghost_opacity.rawValue)) / 100.0
            newView.alpha = CGFloat(alpha)
            // ADD: blur of background, blur of ghost, ghost opacity
            // http://visionsimulations.com/blurry-vision-and-one-ghost.htm
            viewsToRemove.append(newView)
        }
    }
    
    // MARK: Floaters effect
    
    private func addFloaters() {
        guard UserDefaults.standard.bool(forKey: DisabilityCell.floaters.rawValue) else { return }
        
        let imageNames = ["floater-1", "floater-2", "floater-3", "floater-4", "floater-5", "floater-6", "floater-7", "floater-8", "floater-9", "floater-10", "floater-11", "floater-12", "floater-13", "floater-14", "floater-15"]
        imageNames.forEach { imageName in
            let randomNumber = Int.random(in: 0 ..< 5)
            let opacity = CGFloat(Float(randomNumber) / 10.0)
            
            let imageView = UIImageView()
            let image = UIImage(named: imageName)?.alpha(opacity)
            imageView.image = image
            let imageHeight = image?.size.height
            let imageWidth = image?.size.width
            
            let maxYpoint: Float = Float(UIScreen.main.bounds.height) + 50
            let maxXpoint: Float = Float(UIScreen.main.bounds.width) + 50
            
            let randomYposition = Float.random(in: -10 ..< maxYpoint)
            let randomXposition = Float.random(in: -10 ..< maxXpoint)
            
            view.addSubview(imageView) {
                $0.topAnchor == $1.topAnchor + randomYposition
                $0.leftAnchor == $1.leftAnchor + randomXposition
                $0.heightAnchor == imageHeight ?? CGFloat(Float.random(in: 5 ..< 25))
                $0.widthAnchor == imageWidth ?? CGFloat(Float.random(in: 5 ..< 25))
            }
            
            randomAnimation(imageView)
            viewsToRemove.append(imageView)
        }
    }
    
    func randomAnimation(_ view: UIView) {
        func completionMethodX () -> CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            let randomCoordinatesXInt: UInt32 = arc4random_uniform(UInt32(screenWidth))
            let randCoordsX = CGFloat(randomCoordinatesXInt)
            return randCoordsX
        }
        
        func completionMethodY () -> CGFloat {
            let screenHeight = UIScreen.main.bounds.height
            let randomCoordinatesYInt: UInt32 = arc4random_uniform(UInt32(screenHeight))
            let randCoordsY = CGFloat(randomCoordinatesYInt)
            return randCoordsY
        }
        
        UIView.animate(withDuration: Double(Int.random(in: 20 ..< 40)), delay: TimeInterval.zero, options: [], animations: { // [.repeat, .autoreverse]
            view.center.x = completionMethodX()
            view.center.y = completionMethodY()
        }, completion: { finished in
            self.randomAnimation(view)
        })
    }
    
    // MARK: Color Deficiency effect
    
    private func addColorDeficiency() {
        guard UserDefaults.standard.bool(forKey: DisabilityCell.color_blindness.rawValue) else { return }
        
        let chosenKey = DisabilityCell.color_blindness.details.first { UserDefaults.standard.bool(forKey: $0.rawValue) }
        let chosenType = ColorDeficiency.allCases.first { $0.rawValue == chosenKey?.rawValue }
        guard let type = chosenType else { return }
        
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let newImageView = UIImageView()
        view.addSubview(newImageView) {
            $0.topAnchor == view.topAnchor
            $0.bottomAnchor == view.bottomAnchor
            $0.rightAnchor == view.rightAnchor
            $0.leftAnchor == view.leftAnchor
        }
        let image = renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }.colorDeficiencyFilter(type: type)
        newImageView.image = image
        newImageView.isUserInteractionEnabled = false
        viewsToRemove.append(newImageView)
    }
    
    // MARK: Cataracts (cloudiness) effect
    
    private func addCataracts() { // cloudiness
        guard UserDefaults.standard.bool(forKey: DisabilityCell.cataracts.rawValue) else { return }
        let alpha = Float(UserDefaults.standard.integer(forKey: DisabilityDetail.cataracts_intensity.rawValue)) / 100.0
        
        let cataractsImageView = UIImageView()
        cataractsImageView.image = UIImage(named: "cataracts")?.alpha(CGFloat(alpha))
        
        let imageWidth = UIScreen.main.bounds.height * 1.5
        view.addSubview(cataractsImageView) {
            $0.topAnchor == $1.topAnchor
            $0.bottomAnchor == $1.bottomAnchor
            $0.widthAnchor == imageWidth
            $0.centerXAnchor == $1.centerXAnchor
        }
        viewsToRemove.append(cataractsImageView)
    }
    
    // MARK: Hemianopia (side) effect
    
    private func addHemianopia() { // Side (hemianopia)
        guard UserDefaults.standard.bool(forKey: DisabilityCell.hemianopia.rawValue) else { return }
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.2, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        //        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor] ja no labās puses
        //        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.addSublayer(gradient)
        layersToRemove.append(gradient)
    }
    
    // MARK: Diabetic Retinopathy effect
    
    private func addDiabeticRetinopathy() {
        guard UserDefaults.standard.bool(forKey: DisabilityCell.diabetic_retinopathy.rawValue) else { return }
        
        let diabeticRetinopathyImageView = UIImageView()
        diabeticRetinopathyImageView.image = UIImage(named: "diabetic-retinopathy")?.alpha(0.4)
        
        let imageWidth = UIScreen.main.bounds.height * 1.5
        view.addSubview(diabeticRetinopathyImageView) {
            $0.topAnchor == $1.topAnchor
            $0.bottomAnchor == $1.bottomAnchor
            $0.widthAnchor == imageWidth
            $0.centerXAnchor == $1.centerXAnchor
        }
        viewsToRemove.append(diabeticRetinopathyImageView)
    }
    
    // MARK: Retinal Detachment effect
    
    private func addRetinalDetachment(horizontalMode: Bool, diagonalMode: Bool) { // Retinal detachment (stūris)
        guard UserDefaults.standard.bool(forKey: DisabilityCell.retinal_detachment.rawValue) else { return }
        
        let retinalDetachmentImageView = UIImageView()
        retinalDetachmentImageView.image = UIImage(named: "dark-spots")
        
        view.addSubview(retinalDetachmentImageView) {
            $0.topAnchor == $1.topAnchor
            $0.bottomAnchor == $1.bottomAnchor
            $0.leftAnchor == $1.leftAnchor
            $0.rightAnchor == $1.rightAnchor
        }
        viewsToRemove.append(retinalDetachmentImageView)
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        
        let intensity = 0.15
        
        gradientLayer.locations = [NSNumber(value: intensity), 0.25]
        
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: intensity)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: intensity)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: intensity, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: intensity, y: 1)
        }
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        
        self.view.layer.addSublayer(gradientLayer)
        layersToRemove.append(gradientLayer)
    }
    
    // MARK: Motor disability: Remove gesture recoznizers
    
    private func removeGestureRecogznizers() {
        view.subviews.forEach { subview in
            guard subview != bubbleButton else { return }
            subview.gestureRecognizers?.forEach { gestureRecognizer in
                switch gestureRecognizer {
                case let tap as UITapGestureRecognizer:
                    
                    let areLimitationsEnabled = UserDefaults.standard.bool(forKey: DisabilityCell.no_tap.rawValue)
                    
                    let canPassLimitation1 = tap.numberOfTapsRequired <= UserDefaults.standard.integer(forKey: DisabilityDetail.gesture_tap_number_of_taps_required.rawValue)
                    
                    let canPassLimitation2 = tap.numberOfTouchesRequired <= UserDefaults.standard.integer(forKey: DisabilityDetail.gesture_tap_number_of_touches_required.rawValue)
                    
                    gestureRecognizer.isEnabled = !areLimitationsEnabled || (canPassLimitation1 && canPassLimitation2)
                    
                case is UIPinchGestureRecognizer:
                    gestureRecognizer.isEnabled = !UserDefaults.standard.bool(forKey: DisabilityCell.no_pinch.rawValue)
                case is UIRotationGestureRecognizer:
                    gestureRecognizer.isEnabled = !UserDefaults.standard.bool(forKey: DisabilityCell.no_rotation.rawValue)
                case is UISwipeGestureRecognizer:
                    gestureRecognizer.isEnabled = !UserDefaults.standard.bool(forKey: DisabilityCell.no_swipe.rawValue)
                case is UIPanGestureRecognizer:
                    gestureRecognizer.isEnabled = !UserDefaults.standard.bool(forKey: DisabilityCell.no_pan.rawValue)
                case is UIScreenEdgePanGestureRecognizer:
                    gestureRecognizer.isEnabled = !UserDefaults.standard.bool(forKey: DisabilityCell.no_screen_edge_pan.rawValue)
                case is UILongPressGestureRecognizer:
                    gestureRecognizer.isEnabled = !UserDefaults.standard.bool(forKey: DisabilityCell.no_long_press.rawValue)
                default:
                    break
                }
            }}
    }
    
    // MARK: Cognitive: adhd
    
    private func animateFocusDifficulties() {
        guard UserDefaults.standard.bool(forKey: DisabilityCell.adhd.rawValue) else { return }
        
        let unfocusedView = UIView()
        view.addSubview(unfocusedView) {
            $0.topAnchor == $1.topAnchor
            $0.bottomAnchor == $1.bottomAnchor
            $0.leftAnchor == $1.leftAnchor
            $0.rightAnchor == $1.rightAnchor
        }
        unfocusedView.isUserInteractionEnabled = false
        unfocusedView.backgroundColor = UIColor.clear
        hideViewRandomly(unfocusedView)
        
        viewsToRemove.append(unfocusedView)
    }
    
    private func hideViewRandomly(_ viewToHide: UIView) {
        UIView.animate(withDuration: Double.random(in: 1 ..< 10), delay: TimeInterval.random(in: 10 ..< 20), options: [.autoreverse], animations: {
            viewToHide.backgroundColor = UIColor.black
        }, completion: { finished in
            viewToHide.backgroundColor = UIColor.clear
            self.hideViewRandomly(viewToHide)
        })
    }
    
    //  MARK: Cognitive: dysgraphia
    
    private func manipulateKeyboard() {
        guard UserDefaults.standard.bool(forKey: DisabilityCell.dysgraphia.rawValue) else { return }

        view.subviews.compactMap { $0 as? UITextField }.forEach { textfield in
            textfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.text = textField.text?.lowercased()
    }
    
    // MARK: Hearing
}

public class InclusivityAVAudioPlayer: AVAudioPlayer {
    override public var volume: Float {
        get {
            return super.volume
        } set {
            if UserDefaults.standard.bool(forKey: DisabilityCell.complete_hearing_loss.rawValue) {
                super.volume = 0
            } else if UserDefaults.standard.bool(forKey: DisabilityCell.partial_hearing_loss.rawValue) {
                super.volume =  max(super.volume - 0.5, 0)
            } else {
                super.volume =  super.volume
            }
        }
    }
}

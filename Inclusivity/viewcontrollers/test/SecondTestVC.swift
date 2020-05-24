//
//  SecondTestVC.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 05/08/2019.
//  Copyright © 2019 makit. All rights reserved.
//

import UIKit
import Anchorage
import AVFoundation

public class SecondTestVC: TestBaseViewController {
    private let exampleButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Spiest pogu", comment: ""), for: .normal)
        button.backgroundColor = UIColor.green
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    private let examplePlayButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play-icon"), for: .normal)
        return button
    }()
    
    private let exampleSlider: UISlider = {
        let slider = UISlider()
        return slider
    }()
    
    private let exampleTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        return label
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
    
    var audioPlayer: AVAudioPlayer?
    var audioData: Data?
    
    
    var duration: TimeInterval = 0
    var isPaused: Bool = false
    
    var progress: Float = 0 {
        didSet {
            exampleSlider.setValue(progress * Float(duration), animated: true)
            let timeLeft = duration * Double(1 - progress)
            exampleTimeLabel.text = "\(timeLeft.getMinutesAndSecondsString())"
            exampleSlider.maximumValue = Float(duration)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
                
        setupView()
        setupPlayer()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        audioPlayer?.stop()
    }
    
    private func setupPlayer() {
        guard let url = Bundle.main.url(forResource: "armstrong", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            audioPlayer?.volume = 0.1
            
            duration = audioPlayer?.duration ?? 0.0
            audioPlayer?.prepareToPlay()
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePlayerTime), userInfo: nil, repeats: true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func didTapPlayButton() {
        if audioPlayer?.isPlaying ?? false {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        isPaused = !isPaused
        examplePlayButton.setImage(isPaused ? #imageLiteral(resourceName: "pause-icon") : #imageLiteral(resourceName: "play-icon"), for: .normal)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        audioPlayer?.currentTime = TimeInterval(sender.value)
    }
    
    @objc func updatePlayerTime() {
        if let player = audioPlayer {
            progress = Float(player.currentTime / player.duration)
        }
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(exampleImageView) {
            $0.topAnchor == $1.topAnchor + 100
            $0.leftAnchor == $1.leftAnchor + 30
            $0.rightAnchor == $1.rightAnchor - 30
            $0.heightAnchor == 100
        }
        
        view.addSubview(examplePlayButton) {
            $0.topAnchor == exampleImageView.bottomAnchor + 25
            $0.leftAnchor == $1.leftAnchor + 10
            $0.widthAnchor == 50
            $0.heightAnchor == 50
        }
        examplePlayButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapPlayButton)))
        
        view.addSubview(exampleSlider) {
            $0.centerYAnchor == examplePlayButton.centerYAnchor
            $0.leftAnchor == examplePlayButton.rightAnchor + 10
            $0.rightAnchor == $1.rightAnchor - 20
        }
        exampleSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        view.addSubview(exampleTimeLabel) {
            $0.topAnchor == exampleSlider.bottomAnchor + 25
            $0.centerXAnchor == $1.centerXAnchor
        }
        
        view.addSubview(exampleDatePicker) {
            $0.topAnchor == exampleTimeLabel.bottomAnchor + 25
            $0.leftAnchor == $1.leftAnchor + 30
            $0.rightAnchor == $1.rightAnchor - 20
        }
        
        view.addSubview(exampleButton) {
            $0.heightAnchor == 50
            $0.leftAnchor == $1.leftAnchor + 30
            $0.rightAnchor == $1.rightAnchor - 30
            $0.bottomAnchor == $1.safeAreaLayoutGuide.bottomAnchor - 30
        }
        exampleButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBasicButtonTap)))
    }
    
    @objc private func handleBasicButtonTap() {
        exampleButton.backgroundColor = UIColor.random()
    }
}

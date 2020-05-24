//
//  TimeInterval.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 24/05/2020.
//  Copyright © 2020 ajinalem. All rights reserved.
//

import Foundation

extension TimeInterval {
    func getMinutesAndSecondsString() -> String {
        let ti = NSInteger(self)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        return String(format: "%0.2d:%0.2d", minutes, seconds)
    }
    var ago: Date {
        return Date(timeIntervalSinceNow: -self)
    }
}

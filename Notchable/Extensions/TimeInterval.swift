//
//  Extensions.swift
//  Notchable
//
//  Created by Oliver Belsey on 13/07/2026.
//

import Foundation

extension TimeInterval {
    func minuteSecondFormat() -> String {
        let minutes = Int(self) / 60
        let seconds = Int(self) - (minutes * 60)
        let minuteString = String(minutes)
        var secondString = String(seconds)
        if seconds < 10 {
            secondString = "0\(seconds)"
        }
        return "\(minuteString):\(secondString)"
    }
}

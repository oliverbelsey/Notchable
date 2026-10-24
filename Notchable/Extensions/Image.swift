//
//  Image.swift
//  Notchable
//
//  Created by Oliver Belsey on 18/10/26.
//

import AppKit
import SwiftUI

extension Image {
    init(imageData: Data) {
        let image = NSImage(data: imageData) ?? NSImage(resource: .sour)
        self.init(nsImage: image)
    }
}

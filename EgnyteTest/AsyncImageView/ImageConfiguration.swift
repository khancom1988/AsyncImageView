//
//  ImageConfiguration.swift
//  EgnyteTest
//
//  Created by Aadil Majeed on 01/10/22.
//

import Foundation

struct ImageConfiguration {
    let url: URL
    let showLoader: Bool
    let animationDuration: TimeInterval
    
    init(url: URL, showLoader: Bool = false, animationDuration: TimeInterval = 0.4) {
        self.url = url
        self.showLoader = showLoader
        self.animationDuration = animationDuration
    }
}

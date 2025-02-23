//
//  TabBarIconView+Animations.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 23/2/25.
//

import AppKit

extension TabBarIconView {
    func fadeInAnimation() {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = .fade
        
        self.layer?.add(transition, forKey: nil)
    }
}

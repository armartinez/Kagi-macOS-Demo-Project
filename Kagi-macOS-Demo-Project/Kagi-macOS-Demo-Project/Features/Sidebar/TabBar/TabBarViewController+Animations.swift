//
//  TabBarViewController+Animations.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 22/2/25.
//

import AppKit

extension TabBarViewController {
    func addIconAnimation(iconView : TabBarIconView) {
        guard let layer = iconView.layer else { return }

        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.3
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            // Scale up animation
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = CATransform3DMakeScale(0.01, 0.01, 0.01)
            animation.toValue = CATransform3DIdentity
            layer.add(animation, forKey: "transform")
            
            // Animate alpha
            iconView.animator().alphaValue = 1.0
        }) {
            // Ensure final state
            iconView.layer?.transform = CATransform3DIdentity
        }
    }
    
    func removeIconAnimation(iconView : TabBarIconView, callback: @escaping () -> Void) {
        guard let layer = iconView.layer else { return }
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.3
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            // Scale down animation
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = CATransform3DIdentity
            animation.toValue = CATransform3DMakeScale(0.01, 0.01, 0.01)
            
            layer.add(animation, forKey: "transform")
            
            // Animate alpha
            iconView.animator().alphaValue = 0.0
        }) {
            callback()
        }
    }
}

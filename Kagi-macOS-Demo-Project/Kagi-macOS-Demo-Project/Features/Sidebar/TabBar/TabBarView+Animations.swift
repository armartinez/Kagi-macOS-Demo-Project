//
//  TabBarView+Animations.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 23/2/25.
//

import AppKit

extension TabBarView {
    func collapseWithAnimation() {
        self.animator().spacing = isCollapsed ? collapsedSpacing : defaultSpacing
    }
}

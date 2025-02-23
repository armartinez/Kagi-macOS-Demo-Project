//
//  TabBarView.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 19/2/25.
//

import AppKit

class TabBarView: NSStackView {
    let defaultSpacing: CGFloat = 14
    let collapsedSpacing: CGFloat = 8
    
    weak var selectedIcon: TabBarIconView?
    
    var hasChanged = false
    
    var isCollapsed: Bool = false {
        // Handles collapsed state of icons
        didSet {
            collapseWithAnimation()
            
            for view in self.arrangedSubviews {
                guard let iconView = view as? TabBarIconView else { continue }
            
                if iconView.workspaceIdentifier == selectedIcon?.workspaceIdentifier { continue }
                
                iconView.isCollapsed = isCollapsed
            }
        }
    }

    override func layout() {
        super.layout()
        
        // Prevents re-checking the layout again after changing collapsed state
        if hasChanged {
            checkCollapsed()
            
            self.hasChanged = false
        }
    }
    
    func checkCollapsed() {
        guard let superview = self.superview else { return }
        
        // Checks if view is big enough to collapse the icons
        let padding: CGFloat = isCollapsed ? 100 : 50
        let overflown = (self.bounds.width+padding) > superview.bounds.width
        
        // Changes collapsed state
        if overflown && !isCollapsed || !overflown && isCollapsed {
            self.isCollapsed.toggle()
        }
    }
    
    func addIcon(_ iconView: TabBarIconView) {
        let index = arrangedSubviews.count - 1
        
        self.insertArrangedSubview(iconView, at: index)
        self.hasChanged = true
    }
    
    func removeIcon(_ iconView: TabBarIconView) {
        iconView.removeFromSuperview()

        self.hasChanged = true
    }
}

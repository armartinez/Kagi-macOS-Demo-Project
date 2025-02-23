//
//  TabBarViewController+Handlers.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 21/2/25.
//

import AppKit

extension TabBarViewController {
    
    @objc func handleSelect(_ gesture: NSClickGestureRecognizer) {
        guard let iconView = gesture.view as? TabBarIconView else { return }
        
        self.selectTabBarIcon(iconView)
    }
    
    @objc func handleAdd(_ gesture: NSClickGestureRecognizer) {
        // Select a random workspace
        guard let item = WorkspaceType.allCases.randomElement() else { return }
        
        var workspace: Workspace
        
        switch item {
        case .file:
            workspace = WorkspaceManager.fileWorkspace
            break
        case .source:
            workspace = WorkspaceManager.sourceWorkspace
            break
        case .project:
            workspace = WorkspaceManager.projectWorkspace
            break
        }
        
        let iconView = self.addTabBarIcon(workspace)
        
        self.selectTabBarIcon(iconView)
    }
    
    @objc func handleRemove(_ menuItem: NSMenuItem) {
        guard let identifier = menuItem.representedObject as? UUID else { return }
        
        // Gets the icons excluding the add icon
        let icons = tabBarView.arrangedSubviews.compactMap { $0 as? TabBarIconView }
        
        var nextIconIndex = 0
        
        // Check if removed item is selected
        if let selectedIcon = tabBarView.selectedIcon,
           identifier == selectedIcon.workspaceIdentifier,
           let selectedIndex = icons.firstIndex(of: selectedIcon) {
            
            // Checks if index can be set to next or previous icon, else set to zero
            nextIconIndex = selectedIndex + 1
            if nextIconIndex > (icons.count - 1) {
                nextIconIndex = selectedIndex - 1
            }
        }
        
        if nextIconIndex > -1 {
            self.removeTabBarIcon(identifier: identifier)
            self.selectTabBarIcon(icons[nextIconIndex])
        } else {
            self.removeTabBarIcon(identifier: identifier)
        }
    }
    
    @objc func handleResize(_ notification: Notification) {
        self.tabBarView.checkCollapsed()
    }
    
    @objc func handleSwipe(_ gesture: NSPanGestureRecognizer) {
        let icons = tabBarView.arrangedSubviews.compactMap { $0 as? TabBarIconView }
        
        guard let selectedIcon = tabBarView.selectedIcon,
              let selectedIndex = icons.firstIndex(of: selectedIcon)
        else { return }
        
        switch gesture.state {
        case .began:
            initialLocation = gesture.location(in: view)
        case .ended:
            let currentLocation = gesture.location(in: view)
            let dx = currentLocation.x - initialLocation.x
            // Check if the horizontal movement exceeds the threshold
            if abs(dx) >= swipeThreshold {
                var index = 0
                
                // Check if right or left icon can be selected
                if dx > 0, selectedIndex > 0 {
                    index = selectedIndex - 1
                } else if dx < 0, selectedIndex < icons.count - 1 {
                    index = selectedIndex + 1
                } else { return }
                
                let nextIcon = icons[index]
                
                self.selectTabBarIcon(nextIcon)
            }
        default:
            break
        }
    }
}

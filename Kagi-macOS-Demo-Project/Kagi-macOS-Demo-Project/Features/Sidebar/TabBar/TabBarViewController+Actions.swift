//
//  TabBarViewController+Actions.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 21/2/25.
//

import AppKit

extension TabBarViewController {
    
    func selectTabBarIcon(_ iconView: TabBarIconView) {
        if let selectedIcon = tabBarView.selectedIcon {
            selectedIcon.isCollapsed = tabBarView.isCollapsed
            selectedIcon.isSelected = false
        }
        
        iconView.isCollapsed = false
        iconView.isSelected = true
        
        let identifier = iconView.workspaceIdentifier
        
        self.tabBarView.selectedIcon = iconView
        self.delegate?.tabBar(didSelectItem: identifier)
        
        NotificationCenter.default.post(name: .workspaceSelected, object: identifier)
    }
    
    func addTabBarIcon(_ workspace: Workspace) -> TabBarIconView {
        let iconView = TabBarIconView(workspaceIdentifier: workspace.identifier, symbolName: workspace.tabItem.symbolName)
        
        // Set weak reference to parent view
        iconView.parent = tabBarView
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.symbolConfiguration = .init(pointSize: 14, weight: .regular)
        
        if let image = NSImage(systemSymbolName: workspace.tabItem.symbolName, accessibilityDescription: workspace.tabItem.name) {
            iconView.image = image
        }
        
        iconView.isEnabled = true
        
        // Use gesture instead of action to prevent conflicts with pan gesture
        let leftClick = NSClickGestureRecognizer(target: self, action: #selector(handleSelect(_:)))
        
        iconView.addGestureRecognizer(leftClick)
        iconView.toolTip = workspace.tabItem.name
        iconView.imageScaling = .scaleNone
        iconView.wantsLayer = true
        
        let menu = NSMenu()
        
        // Create the delete menu item with a trash icon
        let deleteItem = NSMenuItem(
            title: "Delete",
            action: #selector(self.handleRemove(_:)),
            keyEquivalent: ""
        )
        
        deleteItem.image = NSImage(systemSymbolName: "trash", accessibilityDescription: "Delete")
        deleteItem.representedObject = workspace.identifier
        
        menu.addItem(deleteItem)
        
        // Add the menu to the image view
        iconView.menu = menu
        
        self.tabBarView.addIcon(iconView)
        
        addIconAnimation(iconView: iconView)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // Add tracking area for hover animation
        let trackingArea = NSTrackingArea(
            rect: iconView.bounds,
            options: [NSTrackingArea.Options.mouseEnteredAndExited,
                      NSTrackingArea.Options.activeAlways,
                      NSTrackingArea.Options.inVisibleRect],
            owner: iconView,
            userInfo: nil
        )
        
        iconView.addTrackingArea(trackingArea)
        
        self.delegate?.tabBar(didAddItem: workspace)
        
        // Notify content controller
        NotificationCenter.default.post(name: .workspaceAdded, object: workspace)
        
        return iconView
    }
    
    func removeTabBarIcon(identifier: UUID) {
        guard let iconView = tabBarView.arrangedSubviews
            .compactMap({ $0 as? TabBarIconView })
            .first(where: { $0.workspaceIdentifier == identifier })
        else {
            return
        }
        
        removeIconAnimation(iconView: iconView) { [weak self, weak tabBarView] in
            // Remove icon
            tabBarView?.removeIcon(iconView)
            
            // Remove selection if last
            if tabBarView?.arrangedSubviews
                .compactMap({ $0 as? TabBarIconView }).isEmpty ?? true {
                tabBarView?.selectedIcon = nil
            }
            
            // Remove workspace controller
            self?.delegate?.tabBar(didRemoveItem: identifier)
            
            // Notify content controller
            NotificationCenter.default.post(
                name: .workspaceRemoved,
                object: identifier
            )
        }
    }
}

//
//  MainViewController+NSToolbar.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 13/2/25.
//

import AppKit

extension MainWindowController: NSToolbarDelegate {
    
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        switch(itemIdentifier) {
        case NSToolbarItem.Identifier.titleItem:
            let toolbarItem = NSToolbarItem(itemIdentifier: NSToolbarItem.Identifier.titleItem)
            let titleView = NSTextField(labelWithString: "Kagi macOS Demo Project")
            
            titleView.translatesAutoresizingMaskIntoConstraints = false
            titleView.font = .titleBarFont(ofSize: 16)
            titleView.textColor = .labelColor
            
            toolbarItem.view = titleView
            
            return toolbarItem
        default:
            return NSToolbarItem(itemIdentifier: itemIdentifier)
        }
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        var toolbarItemIdentifiers = [NSToolbarItem.Identifier]()
        toolbarItemIdentifiers.append(.sidebarTrackingSeparator)
        toolbarItemIdentifiers.append(.toggleSidebar)
        toolbarItemIdentifiers.append(.titleItem)
        toolbarItemIdentifiers.append(.flexibleSpace)
        
        return toolbarItemIdentifiers
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return self.toolbarDefaultItemIdentifiers(toolbar)
    }
}

extension NSToolbarItem.Identifier {
    static let titleItem: NSToolbarItem.Identifier = NSToolbarItem.Identifier("TitleItem")
}

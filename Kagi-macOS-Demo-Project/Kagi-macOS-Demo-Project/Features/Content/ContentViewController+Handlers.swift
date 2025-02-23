//
//  ContentViewController+Handlers.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 22/2/25.
//

import AppKit

extension ContentViewController {
    @objc func handleContentSelect(_ notification: Notification) {
        guard let identifier = notification.object as? UUID else { return }
        
        contentSelected(didSelectItem: identifier)
    }
    
    @objc func handleContentAdd(_ notification: Notification) {
        guard let workspace = notification.object as? Workspace else { return }
        
        contentAdded(
            didSelectItem: workspace.identifier,
            imageName: workspace.contentImage
        )
    }
    
    @objc func handleContentRemoved(_ notification: Notification) {
        guard let identifier = notification.object as? UUID else { return }
        
        contentRemoved(didSelectItem: identifier)
    }
}

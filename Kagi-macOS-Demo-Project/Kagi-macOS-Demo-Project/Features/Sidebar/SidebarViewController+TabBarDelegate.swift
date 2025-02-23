//
//  SidebarViewController+TabBarDelegate.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 19/2/25.
//

import AppKit

extension SidebarViewController: TabBarDelegate {
    func tabBar(didSelectItem identifier: UUID) {
        let controllers = workspaceContainer.children.compactMap { $0 as? WorkspaceViewController }
        
        guard let newViewController = controllers.first(where: { $0.workspace.identifier == identifier }),
              let index = controllers.firstIndex(of: newViewController)
        else {
            return
        }
 
        // Transition animation to the next view controller
        if let currentViewController = selectedTab, let selectedTabIndex = controllers.firstIndex(of: currentViewController) {
            let transition: NSViewController.TransitionOptions = index > selectedTabIndex ? .slideForward : .slideBackward
            
            self.workspaceContainer.transition(from: currentViewController, to: newViewController, options: transition)
        } else {
            guard let emptyViewController = workspaceContainer.children.first else { return }
            
            self.workspaceContainer.transition(from: emptyViewController, to: newViewController, options: .slideForward)
        }
        
        NSLayoutConstraint.activate([
            newViewController.view.topAnchor.constraint(equalTo: workspaceContainer.view.topAnchor),
            newViewController.view.widthAnchor.constraint(equalTo: workspaceContainer.view.widthAnchor)
        ])
        
        self.selectedTab = newViewController
    }

    func tabBar(didAddItem item: Workspace) {
        let controller = WorkspaceViewController(workspace: item)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.workspaceContainer.addChild(controller)
    }

    func tabBar(didRemoveItem identifier: UUID) {
        let controllers = workspaceContainer.children.compactMap { $0 as? WorkspaceViewController }
        
        guard let viewController = controllers.first(where: { $0.workspace.identifier == identifier })
        else {
            return
        }
        
        // If it's last controller, transition to empty
        if controllers.count == 1 {
            guard let emptyViewController = workspaceContainer.children.first else { return }
            
            self.workspaceContainer.transition(from: viewController, to: emptyViewController, options: .slideBackward)
            
            self.selectedTab = nil
        }
        
        viewController.removeFromParent()
        viewController.view.removeFromSuperview()
    }
}

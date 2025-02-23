//
//  ContentViewController+Actions.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 22/2/25.
//

import AppKit

extension ContentViewController {
    func contentAdded(didSelectItem identifier: UUID, imageName: String) {
        let controller = ImageViewController(
            workspaceIdentifier: identifier,
            imageName: imageName
        )
        
        self.children.append(controller)
    }
    
    func contentRemoved(didSelectItem identifier: UUID) {
        guard let controller = self.children
            .compactMap({ $0 as? ImageViewController })
            .first(where: { $0.workspaceIdentifier == identifier })
        else {
            return
        }
        
        // If it's last controller, switch to empty
        if children.count == 2 {
            guard let emptyViewController = children.first else { return }
            
            self.transition(from: controller, to: emptyViewController, options: .slideForward)
            
            self.selectedContent = nil
        }
        
        controller.removeFromParent()
    }
    
    func contentSelected(didSelectItem identifier: UUID) {
        guard let newViewController = self.children
            .compactMap({ $0 as? ImageViewController })
            .first(where: { $0.workspaceIdentifier == identifier })
        else {
            return
        }
        
        if let currentViewController = selectedContent {
            self.transition(from: currentViewController, to: newViewController, options: .crossfade)
        } else {
            guard let emptyViewController = self.children.first else { return }
            
            self.transition(from: emptyViewController, to: newViewController, options: .slideForward)
        }
        
        newViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        guard let contentView = self.view.window?.contentView else { return }
        
        NSLayoutConstraint.activate([
            newViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: contentView.safeAreaInsets.top),
            newViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        self.selectedContent = newViewController
    }
}

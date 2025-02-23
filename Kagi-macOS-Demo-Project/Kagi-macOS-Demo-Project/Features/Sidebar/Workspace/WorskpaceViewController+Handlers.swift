//
//  WorskpaceViewController+Handlers.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 22/2/25.
//

import AppKit

extension WorkspaceViewController {
    @objc func handleTopIconClick(_ gesture: NSClickGestureRecognizer) {
        guard let topIcon = gesture.view as? NSButton else { return }
        selectTopIcon(topIcon)
    }
    
    @objc func handleListItemClicked(_ gesture: NSClickGestureRecognizer) {
        guard let listItem = gesture.view else { return }
        selectListItem(listItem)
    }
}

//
//  WorkspaceViewController+GestureRecognizerDelegate.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 22/2/25.
//

import AppKit

extension SidebarViewController: NSGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: NSGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: NSGestureRecognizer) -> Bool {
        // Allow simultaneous recognition with click gestures
        return otherGestureRecognizer is NSClickGestureRecognizer
    }
}

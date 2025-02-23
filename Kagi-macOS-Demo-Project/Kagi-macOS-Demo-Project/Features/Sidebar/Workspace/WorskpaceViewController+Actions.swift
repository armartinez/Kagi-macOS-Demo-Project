//
//  WorskpaceViewController+Actions.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 22/2/25.
//

import AppKit

extension WorkspaceViewController {
    func selectTopIcon(_ button: NSButton) {
        button.bezelColor = .quinaryLabel
         
        deselectPreviousItem()
        
        self.selectedItem = button
    }
    
    func selectListItem(_ listItem: NSView) {
        listItem.layer?.cornerRadius = 8
        listItem.layer?.backgroundColor = NSColor.tertiaryLabelColor.cgColor
        
        deselectPreviousItem()
        
        self.selectedItem = listItem
    }
    
    private func deselectPreviousItem() {
        if let previousSelection = selectedItem as? NSButton {
            previousSelection.bezelColor = nil
        } else if let previousSelection = selectedItem  {
            previousSelection.layer?.backgroundColor = .clear
        }
    }
}

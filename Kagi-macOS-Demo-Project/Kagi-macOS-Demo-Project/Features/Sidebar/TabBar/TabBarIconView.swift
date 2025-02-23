//
//  TabBarIconView.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 21/2/25.
//

import AppKit

class TabBarIconView: NSImageView {
    let workspaceIdentifier: UUID
    let symbolName: String

    weak var parent: TabBarView?
    
    var isCollapsed: Bool = false {
        didSet {
            let newImage: NSImage?
            
            if isCollapsed {
                let config = NSImage.SymbolConfiguration(pointSize: CGFloat(6), weight: .light)
                let icon = NSImage(systemSymbolName: "circle.fill", accessibilityDescription: nil)
                
                newImage = icon?.withSymbolConfiguration(config)
            } else {
                newImage = NSImage(systemSymbolName: symbolName, accessibilityDescription: nil)
            }
            
            self.image = newImage
        }
    }
    
    var isSelected: Bool = false {
        didSet {
            self.contentTintColor = isSelected ? .controlAccentColor : .secondaryLabelColor
        }
    }
    
    init(workspaceIdentifier: UUID, symbolName: String) {
        self.workspaceIdentifier = workspaceIdentifier
        self.symbolName = symbolName
        
        super.init(frame: .zero)
        
        // Enable layer for animations
        self.wantsLayer = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Mouse tracking
    
    override func mouseEntered(with theEvent: NSEvent) {
        super.mouseEntered(with: theEvent)
        
        if isCollapsed {
            self.isCollapsed = false
            fadeInAnimation()
        }
    }
    
    override func mouseExited(with theEvent: NSEvent) {
        super.mouseExited(with: theEvent)
        
        if parent?.isCollapsed ?? false && !isSelected {
            self.isCollapsed = true
        }
    }
}

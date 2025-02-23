//
//  ContentViewController.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 22/2/25.
//


import AppKit

class ImageViewController: NSViewController {
    var workspaceIdentifier: UUID
    var imageName: String
    
    init(workspaceIdentifier: UUID, imageName: String) {
        self.workspaceIdentifier = workspaceIdentifier
        self.imageName = imageName
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        guard let image = NSImage(named:imageName) else { return }
        
        let imageView = NSImageView(image: image)
        // Adjust resize quality
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        self.view = imageView
    }
}

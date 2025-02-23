//
//  ContentViewController.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 13/2/25.
//

import AppKit

class ContentViewController: NSViewController {
    
    weak var selectedContent: ImageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Empty controller added for animating the first image into view
        let emptyViewController = NSViewController()
        
        self.addChild(emptyViewController)
        self.view.addSubview(emptyViewController.view)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleContentSelect(_:)),
            name: .workspaceSelected,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleContentAdd(_:)),
            name: .workspaceAdded,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleContentRemoved(_:)),
            name: .workspaceRemoved,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: .workspaceSelected,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: .workspaceAdded,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: .workspaceRemoved,
            object: nil
        )
    }
}

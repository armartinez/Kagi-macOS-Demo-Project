//
//  MainViewController.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 12/2/25.
//

import AppKit

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
        let toolbar = NSToolbar(identifier: "toolbar")
        toolbar.delegate = self
        toolbar.displayMode = .iconOnly
        toolbar.allowsUserCustomization = false
 
        guard let window = self.window else { return }
        
        window.titleVisibility = .hidden
        window.styleMask = [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView]
        window.toolbar = toolbar
        window.toolbarStyle = .unified
        window.titlebarSeparatorStyle = .automatic
    }
}

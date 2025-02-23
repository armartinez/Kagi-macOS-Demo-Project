//
//  TabBarViewController.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 19/2/25.
//

import AppKit

protocol TabBarDelegate: NSViewController {
    func tabBar(didAddItem item: Workspace)
    func tabBar(didRemoveItem id: UUID)
    func tabBar(didSelectItem id: UUID)
}

class TabBarViewController: NSViewController {
    weak var delegate: TabBarDelegate?
    
    var initialLocation: NSPoint = .zero
    
    // Computed property to access s core view
    var tabBarView: TabBarView {
        return self.view as! TabBarView
    }
    
    let swipeThreshold: CGFloat = 50.0
    
    override func loadView() {
        let tabBarView = TabBarView()
        
        tabBarView.orientation = .horizontal
        tabBarView.spacing = tabBarView.defaultSpacing
        tabBarView.alignment = .centerY
        tabBarView.wantsLayer = true
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view = tabBarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addIconView = NSImageView()
        addIconView.translatesAutoresizingMaskIntoConstraints = false
        addIconView.symbolConfiguration = .init(pointSize: 14, weight: .regular)
        
        if let image = NSImage(systemSymbolName: "plus.circle.dashed", accessibilityDescription: "Add workspace") {
            addIconView.image = image
        }
    
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleAdd(_:)))
        addIconView.addGestureRecognizer(clickGesture)
        
        self.tabBarView.addArrangedSubview(addIconView)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleResize),
            name: NSSplitView.didResizeSubviewsNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: NSSplitView.didResizeSubviewsNotification,
            object: nil
        )
    }
    
}

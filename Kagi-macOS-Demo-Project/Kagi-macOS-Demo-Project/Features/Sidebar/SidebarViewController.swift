//
//  SidebarViewController.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 13/2/25.
//

import AppKit

class SidebarViewController: NSViewController {
    private let stackView = NSStackView(views: [])
    private let tabBar = TabBarViewController()
    
    let workspaceContainer = NSViewController()
    
    weak var selectedTab: WorkspaceViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stackView.orientation = .vertical
        
        // Create and configure tab bar
        self.tabBar.delegate = self
        self.tabBar.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Add to view hierarchy
        self.addChild(tabBar)
        self.stackView.addArrangedSubview(tabBar.view)
        
        // Add separator line
        let separator = NSBox()
        separator.boxType = .separator
        
        self.stackView.addArrangedSubview(separator)
        
        // Added empty controller for first transition animation
        let emptyViewController = NSViewController()
        emptyViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.workspaceContainer.addChild(emptyViewController)
        self.workspaceContainer.view.addSubview(emptyViewController.view)
        
        NSLayoutConstraint.activate([
            emptyViewController.view.topAnchor.constraint(equalTo: workspaceContainer.view.topAnchor),
            emptyViewController.view.widthAnchor.constraint(equalTo: workspaceContainer.view.widthAnchor)
        ])
        
        let gesture = NSPanGestureRecognizer(target: tabBar, action: #selector(tabBar.handleSwipe(_:)))
        gesture.delegate = self
        
        self.workspaceContainer.view.addGestureRecognizer(gesture)
        
        self.addChild(workspaceContainer)
        self.stackView.addArrangedSubview(workspaceContainer.view)
    
        // Setup container view
        self.workspaceContainer.view.wantsLayer = true
        self.workspaceContainer.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        // Constraints are setup here in order to have access to the window object
        guard let contentView = self.view.window?.contentView else { return }

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: contentView.safeAreaInsets.top+10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBar.view.leadingAnchor.constraint(greaterThanOrEqualTo: stackView.leadingAnchor, constant: 20),
            tabBar.view.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            tabBar.view.heightAnchor.constraint(equalToConstant: 15),
            workspaceContainer.view.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            workspaceContainer.view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            workspaceContainer.view.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
}

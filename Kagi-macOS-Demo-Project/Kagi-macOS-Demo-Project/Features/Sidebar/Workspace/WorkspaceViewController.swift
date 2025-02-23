//
//  WorkspaceViewController.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 19/2/25.
//

import AppKit

class WorkspaceViewController: NSViewController {
    weak var selectedItem: NSView?
    
    var workspace: Workspace
    var workspaceView: NSStackView {
        return self.view as! NSStackView
    }

    init(workspace: Workspace) {
        self.workspace = workspace
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let workspaceView = NSStackView()
        workspaceView.orientation = .vertical
        workspaceView.alignment = .leading
        workspaceView.spacing = 10
        
        self.view = workspaceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let titleLabel = NSTextField(labelWithString: workspace.tabItem.name ?? "")
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .tertiaryLabelColor
        
        let topIconsView = configureTopIcons(workspace.topItems)
        let listView = configureListItems(workspace.listItems)
      
        self.workspaceView.addArrangedSubview(titleLabel)
        self.workspaceView.addArrangedSubview(topIconsView)
        self.workspaceView.addArrangedSubview(listView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        topIconsView.translatesAutoresizingMaskIntoConstraints = false
        listView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            topIconsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            topIconsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            listView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
        ])
    }
    
    private func configureTopIcons(_ topItems: [WorkspaceItem]) -> NSStackView {
        let topIconsView = NSStackView()
        topIconsView.orientation = .horizontal
        topIconsView.spacing = 10
        topIconsView.alignment = .centerY
        
        for item in topItems {
            let button = NSButton()
            let config = NSImage.SymbolConfiguration(pointSize: CGFloat(32), weight: .light)
            let icon = NSImage(systemSymbolName: item.symbolName, accessibilityDescription: nil)
            let gesture = NSClickGestureRecognizer(target: self, action: #selector(handleTopIconClick(_:)))
            
            button.contentTintColor = .secondaryLabelColor
            button.image = icon?.withSymbolConfiguration(config)
            button.imagePosition = .imageOnly
            button.bezelStyle = .regularSquare
            button.isBordered = true
            button.target = self
            // Added gesture intead of action to prevent conflicts with pan gesture
            button.addGestureRecognizer(gesture)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 64),
                button.heightAnchor.constraint(equalToConstant: 64)
            ])
            
            topIconsView.addArrangedSubview(button)
        }
        
        return topIconsView
    }
    
    private func configureListItems(_ listItems: [WorkspaceItem])  -> NSStackView  {
        let listItemsView = NSStackView()
        listItemsView.orientation = .vertical
        listItemsView.spacing = 0
        listItemsView.alignment = .leading

        for item in listItems {
            guard let name = item.name else { continue }
            
            let itemView = NSView()
            let gesture = NSClickGestureRecognizer(target: self, action: #selector(handleListItemClicked(_:)))
            
            itemView.addGestureRecognizer(gesture)
            itemView.wantsLayer = true
            
            let icon = NSImageView()
            icon.image = NSImage(systemSymbolName: item.symbolName, accessibilityDescription: nil)

            let label = NSTextField(labelWithString: name)
            label.font = .systemFont(ofSize: 14)

            itemView.addSubview(icon)
            itemView.addSubview(label)
            
            listItemsView.addArrangedSubview(itemView)
            
            icon.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                icon.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 8),
                icon.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
                icon.widthAnchor.constraint(equalToConstant: 24),
                icon.heightAnchor.constraint(equalToConstant: 24),
                label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
                label.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
                label.trailingAnchor.constraint(equalTo: itemView.trailingAnchor),
                itemView.heightAnchor.constraint(equalToConstant: 30),
                itemView.widthAnchor.constraint(equalTo: listItemsView.widthAnchor)
            ])
        }
        
        if let firstListItem = listItemsView.arrangedSubviews.first {
            selectListItem(firstListItem)
        }
        
        return listItemsView
    }
}

//
//  Workspace.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 14/2/25.
//
import AppKit

struct Workspace {
    let identifier: UUID
    let contentImage: String
    let tabItem: WorkspaceItem
  
    var topItems: [WorkspaceItem] = []
    var listItems: [WorkspaceItem] = []
}

struct WorkspaceItem {
    let symbolName: String
    let name: String?
    
    init(symbolName: String, name: String? = nil) {
        self.symbolName = symbolName
        self.name = name
    }
}

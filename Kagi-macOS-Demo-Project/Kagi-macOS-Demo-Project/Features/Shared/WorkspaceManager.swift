//
//  WorkspaceManager.swift
//  Kagi-macOS-Demo-Project
//
//  Created by Axel Martinez on 19/2/25.
//

import AppKit

enum WorkspaceType: CaseIterable {
    static var allCases: [WorkspaceType] = [
        .file,
        .project,
        .source
    ]
    
    case file
    case project
    case source
}

class WorkspaceManager {
    static var fileWorkspace: Workspace  {
        return Workspace(
            identifier: UUID(),
            contentImage: "files",
            tabItem: WorkspaceItem(symbolName: "flag", name: "Files"),
            topItems: [
                WorkspaceItem(symbolName: "folder.badge.plus"),
                WorkspaceItem(symbolName: "document.badge.plus")
            ],
            listItems: [
                WorkspaceItem(symbolName: "folder", name: "Project"),
                WorkspaceItem(symbolName: "document", name: "package.swift"),
                WorkspaceItem(symbolName: "text.document", name: "Readme.md")
            ]
        )
    }
    
    static var projectWorkspace: Workspace  {
        return Workspace(
            identifier: UUID(),
            contentImage: "project",
            tabItem: WorkspaceItem(symbolName: "macwindow", name: "Project"),
            topItems: [
                WorkspaceItem(symbolName: "folder"),
                WorkspaceItem(symbolName: "document")
            ],
            listItems: [
                WorkspaceItem(symbolName: "folder", name: "Item 1"),
                WorkspaceItem(symbolName: "document", name: "Item 2"),
                WorkspaceItem(symbolName: "book.closed", name: "Item 3")
            ]
        )
    }
    
    static var sourceWorkspace: Workspace  {
        return Workspace(
            identifier: UUID(),
            contentImage: "source",
            tabItem: WorkspaceItem(symbolName: "bell", name: "Source Control"),
            topItems: [
                WorkspaceItem(symbolName: "arrow.trianglehead.branch"),
                WorkspaceItem(symbolName: "arrow.counterclockwise.circle"),
            ],
            listItems: [
                WorkspaceItem(symbolName: "arrow.trianglehead.branch", name: "Branch 1"),
                WorkspaceItem(symbolName: "arrow.trianglehead.branch", name: "Branch 2")
            ]
        )
    }
}

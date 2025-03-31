//
//  ContentViewModel.swift
//  Iriset
//
//  Created by Zachary Bonner on 3/29/25.
//

import SwiftUI
import UniformTypeIdentifiers

class ContentViewModel: ObservableObject {
    @Published var selectedImage: NSImage?
    @Published var platforms: PlatformSelection = .init()
    @Published var xcodeProjectPath: String = ""
    @Published var shouldGenerateContentsJson: Bool = true
    
    private let iconGenerator = IconGenerator()
    
    func handleDrop(providers: [NSItemProvider]) -> Bool {
        guard let itemProvider = providers.first else { return false }
        
        if itemProvider.hasItemConformingToTypeIdentifier(UTType.fileURL.identifier) {
            itemProvider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { (urlData, error) in
                DispatchQueue.main.async {
                    guard let urlData = urlData as? URL else { return }
                    self.loadImage(from: urlData)
                }
            }
            return true
        }
        return false
    }
    
    private func loadImage(from url: URL) {
        guard let nsImage = NSImage(contentsOf: url) else { return }
        self.selectedImage = nsImage
    }
    
    func chooseXcodeProject() {
        let dialog = NSOpenPanel()
        dialog.title = "Choose Xcode Project"
        dialog.canChooseFiles = true
        dialog.canChooseDirectories = false
        dialog.allowedFileTypes = ["xcodeproj"]
        
        if dialog.runModal() == .OK, let url = dialog.url {
            xcodeProjectPath = url.path
        }
    }
    
    func generateIconSet() {
        guard let selectedImage = selectedImage else { return }
        
        // Locate the existing AppIcon.appiconset folder
        guard let outputFolder = iconGenerator.locateAppIconSetDirectory(in: xcodeProjectPath) else {
            return
        }
        
        // Generate icons for each selected platform
        if platforms.macOS {
            iconGenerator.generateIcons(for: .macOS, from: selectedImage, to: outputFolder)
        }
        if platforms.iOS {
            iconGenerator.generateIcons(for: .iOS, from: selectedImage, to: outputFolder)
        }
        if platforms.watchOS {
            iconGenerator.generateIcons(for: .watchOS, from: selectedImage, to: outputFolder)
        }
        if platforms.visionOS {
            iconGenerator.generateIcons(for: .visionOS, from: selectedImage, to: outputFolder)
        }
        if platforms.iPadOS {
            iconGenerator.generateIcons(for: .iPadOS, from: selectedImage, to: outputFolder)
        }
        
        // Generate Contents.json if needed
        if shouldGenerateContentsJson {
            let images = iconGenerator.allGeneratedImages(for: platforms)
            let contents = iconGenerator.generateContentsJson(for: images)
            iconGenerator.writeContentsJson(contents, to: outputFolder)
        }
    }
}


//
//  ContentView.swift
//  Iriset
//
//  Created by Zachary Bonner on 3/29/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            // Drag and Drop or "Drop an image" area
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.secondary, style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .frame(height: 100)
                
                if let selectedImage = viewModel.selectedImage {
                    Image(nsImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                } else {
                    Text("Drop an image file (JPEG or PNG) here")
                        .foregroundColor(.secondary)
                }
            }
            .onDrop(of: [UTType.image], isTargeted: nil) { providers in
                if let provider = providers.first {
                    provider.loadObject(ofClass: NSImage.self) { object, error in
                        DispatchQueue.main.async {
                            if let image = object as? NSImage {
                                viewModel.selectedImage = image
                            } else {
                                print("Failed to load image: \(error?.localizedDescription ?? "unknown error")")
                            }
                        }
                    }
                    return true
                }
                return false
            }
            
            // Platform checkboxes
            HStack {
                Toggle("macOS", isOn: $viewModel.platforms.macOS)
                Toggle("iOS", isOn: $viewModel.platforms.iOS)
                Toggle("watchOS", isOn: $viewModel.platforms.watchOS)
                Toggle("visionOS", isOn: $viewModel.platforms.visionOS)
                Toggle("iPadOS", isOn: $viewModel.platforms.iPadOS)
            }
            
            // Xcode Project file path
            HStack {
                Text("Xcode Project:")
                TextField("/Users/janedoe/MyApp", text: $viewModel.xcodeProjectPath)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Choose…") {
                    viewModel.chooseXcodeProject()
                }
            }
            
            // Output Settings
            Toggle("Generate Contents.json file", isOn: $viewModel.shouldGenerateContentsJson)
            
            // Generate button
            Button(action: {
                viewModel.generateIconSet()
            }) {
                Text("Generate Icon Set")
                    .frame(minWidth: 150)
            }
            .disabled(viewModel.selectedImage == nil || viewModel.xcodeProjectPath.isEmpty)
            
            Spacer()
        }
        .padding()
    }
}

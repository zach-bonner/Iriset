//
//  IconGenerator.swift
//  Iriset
//
//  Created by Zachary Bonner on 3/29/25.
//

import AppKit

class IconGenerator {
    
    /// Creates (or finds) the AppIcon.appiconset directory in the provided Xcode project path.
    /// Returns the path to the created/found folder.
    func locateAppIconSetDirectory(in xcodeProjectPath: String) -> String? {
        // Get the directory containing the .xcodeproj file
        let projectFolder = (xcodeProjectPath as NSString).deletingLastPathComponent
        
        // Extract the project name by removing the extension from the last path component.
        let projectFileName = (xcodeProjectPath as NSString).lastPathComponent  // e.g. "AppName.xcodeproj"
        let projectName = (projectFileName as NSString).deletingPathExtension   // e.g. "AppName"
        
        // Option 1: Check for Assets.xcassets at the same level as the .xcodeproj file.
        let defaultAssetsPath = projectFolder + "/Assets.xcassets/AppIcon.appiconset"
        if FileManager.default.fileExists(atPath: defaultAssetsPath) {
            return defaultAssetsPath
        }
        
        // Option 2: Check for Assets.xcassets in a subfolder with the project name.
        let subfolderAssetsPath = projectFolder + "/\(projectName)/Assets.xcassets/AppIcon.appiconset"
        if FileManager.default.fileExists(atPath: subfolderAssetsPath) {
            return subfolderAssetsPath
        }
        
        print("Error: Could not locate an existing AppIcon.appiconset folder at the expected paths.")
        return nil
    }
    
    /// Generates all necessary icons for a given platform from a base image.
    func generateIcons(for platform: Platform, from image: NSImage, to outputFolder: String) {
        let sizes = platform.iconSizes
        
        for iconSpec in sizes {
            // Calculate the target pixel dimension (points * scale)
            let targetDimension = iconSpec.size * CGFloat(iconSpec.scale)
            let targetSize = CGSize(width: targetDimension, height: targetDimension)
            
            if let resized = resize(image: image, to: targetSize) {
                let filename = iconSpec.filename
                let filePath = "\(outputFolder)/\(filename)"
                saveImage(resized, to: filePath)
            }
        }
    }
    
    /// Builds a list of all "ImageSpec" (size + filename + idiom, etc.) generated
    /// based on which platforms were selected.
    func allGeneratedImages(for selection: PlatformSelection) -> [ImageSpec] {
        var result: [ImageSpec] = []
        
        if selection.macOS {
            result.append(contentsOf: Platform.macOS.iconSizes)
        }
        if selection.iOS {
            result.append(contentsOf: Platform.iOS.iconSizes)
        }
        if selection.watchOS {
            result.append(contentsOf: Platform.watchOS.iconSizes)
        }
        if selection.visionOS {
            result.append(contentsOf: Platform.visionOS.iconSizes)
        }
        if selection.iPadOS {
            result.append(contentsOf: Platform.iPadOS.iconSizes)
        }
        
        return result
    }
    
    /// Generates the JSON string for the Contents.json file
    func generateContentsJson(for images: [ImageSpec]) -> String {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        let appIconContents = AppIconContents(images: images.map { $0.contentsJsonEntry },
                                              info: .init(version: 1, author: "xcode"))
        
        guard let jsonData = try? jsonEncoder.encode(appIconContents),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return "{}"
        }
        
        return jsonString
    }
    
    /// Writes the Contents.json file to the AppIcon.appiconset folder
    func writeContentsJson(_ contents: String, to folder: String) {
        let filePath = folder + "/Contents.json"
        do {
            try contents.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("Error writing Contents.json: \(error)")
        }
    }
        
    /// Resizes an NSImage to the given CGSize.
    private func resize(image: NSImage, to targetSize: CGSize) -> NSImage? {
        guard let bitmapRep = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: Int(targetSize.width),
            pixelsHigh: Int(targetSize.height),
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: .deviceRGB,
            bytesPerRow: 0,
            bitsPerPixel: 0) else { return nil }
        
        bitmapRep.size = targetSize
        NSGraphicsContext.saveGraphicsState()
        if let context = NSGraphicsContext(bitmapImageRep: bitmapRep) {
            NSGraphicsContext.current = context
            image.draw(in: CGRect(origin: .zero, size: targetSize),
                       from: CGRect(origin: .zero, size: image.size),
                       operation: .copy,
                       fraction: 1.0)
        }
        NSGraphicsContext.restoreGraphicsState()
        
        let newImage = NSImage(size: targetSize)
        newImage.addRepresentation(bitmapRep)
        return newImage
    }
    
    /// Saves an NSImage as PNG to a given file path.
    private func saveImage(_ image: NSImage, to path: String) {
        guard let tiffData = image.tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: tiffData),
              let pngData = bitmap.representation(using: .png, properties: [:]) else {
            return
        }
        
        do {
            try pngData.write(to: URL(fileURLWithPath: path))
        } catch {
            print("Error saving file: \(error)")
        }
    }
}

//
//  ImageSpec.swift
//  Iriset
//
//  Created by Zachary Bonner on 3/29/25.
//

import Foundation

/// Holds metadata for a single icon image.
struct ImageSpec {
    let size: CGFloat
    let scale: Int
    let idiom: String
    let role: String?
    
    // initializer with a default value for 'role'
    init(size: CGFloat, scale: Int, idiom: String, role: String? = nil) {
        self.size = size
        self.scale = scale
        self.idiom = idiom
        self.role = role
    }
    
    var filename: String {
        // e.g. "Icon-20x1-iphone.png"
        let sizeString = size == floor(size) ? "\(Int(size))" : "\(size)"
        let roleString = role != nil ? "-\(role!)" : ""
        return "Icon-\(sizeString)x\(scale)-\(idiom)\(roleString).png"
    }
    
    /// Convert to the dictionary structure required by Xcode in Contents.json
    var contentsJsonEntry: [String: String] {
        var dict: [String: String] = [
            "size": "\(size)x\(size)",
            "idiom": idiom,
            "filename": filename,
            "scale": "\(scale)x"
        ]
        if let role = role {
            dict["role"] = role
        }
        return dict
    }
}

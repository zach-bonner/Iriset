//
//  Platform.swift
//  Iriset
//
//  Created by Zachary Bonner on 3/29/25.
//

import Foundation

enum Platform {
    case macOS
    case iOS
    case watchOS
    case visionOS
    case iPadOS
    
    var iconSizes: [ImageSpec] {
        switch self {
        case .macOS:
            // Typical macOS icon sizes (pt x scale => px).
            // 16x16 @1x, 16x16 @2x, 32x32 @1x, 32x32 @2x, etc.
            return [
                ImageSpec(size: 16, scale: 1, idiom: "mac", role: nil),
                ImageSpec(size: 16, scale: 2, idiom: "mac", role: nil),
                ImageSpec(size: 32, scale: 1, idiom: "mac", role: nil),
                ImageSpec(size: 32, scale: 2, idiom: "mac", role: nil),
                ImageSpec(size: 128, scale: 1, idiom: "mac", role: nil),
                ImageSpec(size: 128, scale: 2, idiom: "mac", role: nil),
                ImageSpec(size: 256, scale: 1, idiom: "mac", role: nil),
                ImageSpec(size: 256, scale: 2, idiom: "mac", role: nil),
                ImageSpec(size: 512, scale: 1, idiom: "mac", role: nil),
                ImageSpec(size: 512, scale: 2, idiom: "mac", role: nil),
            ]
        case .iOS:
            return [
                // iPhone Notification (20pt)
                ImageSpec(size: 20, scale: 1, idiom: "iphone"),
                ImageSpec(size: 20, scale: 2, idiom: "iphone"),
                ImageSpec(size: 20, scale: 3, idiom: "iphone"),
                // iPhone Settings (29pt)
                ImageSpec(size: 29, scale: 1, idiom: "iphone"),
                ImageSpec(size: 29, scale: 2, idiom: "iphone"),
                ImageSpec(size: 29, scale: 3, idiom: "iphone"),
                // iPhone Spotlight (40pt)
                ImageSpec(size: 40, scale: 2, idiom: "iphone"),
                ImageSpec(size: 40, scale: 3, idiom: "iphone"),
                // iPhone App (60pt)
                ImageSpec(size: 60, scale: 2, idiom: "iphone"),
                ImageSpec(size: 60, scale: 3, idiom: "iphone"),
                
                // iPad Notification (20pt)
                ImageSpec(size: 20, scale: 1, idiom: "ipad"),
                ImageSpec(size: 20, scale: 2, idiom: "ipad"),
                // iPad Settings (29pt)
                ImageSpec(size: 29, scale: 1, idiom: "ipad"),
                ImageSpec(size: 29, scale: 2, idiom: "ipad"),
                // iPad Spotlight (40pt)
                ImageSpec(size: 40, scale: 1, idiom: "ipad"),
                ImageSpec(size: 40, scale: 2, idiom: "ipad"),
                // iPad App (76pt)
                ImageSpec(size: 76, scale: 1, idiom: "ipad"),
                ImageSpec(size: 76, scale: 2, idiom: "ipad"),
                // iPad Pro App (83.5pt)
                ImageSpec(size: 83.5, scale: 2, idiom: "ipad"),
                
                // App Store / Marketing icon (1024pt, always 1x)
                ImageSpec(size: 1024, scale: 1, idiom: "ios-marketing")
            ]
        case .watchOS:
            return [
                ImageSpec(size: 48, scale: 2, idiom: "watch", role: "notificationCenter"),
                ImageSpec(size: 55, scale: 2, idiom: "watch", role: "companionSettings"),
                ImageSpec(size: 44, scale: 2, idiom: "watch", role: "appLauncher"),
                ImageSpec(size: 86, scale: 2, idiom: "watch", role: "quickLook"),
                ImageSpec(size: 98, scale: 2, idiom: "watch", role: "longLook"),
            ]
        case .visionOS:
            return [
                ImageSpec(size: 128, scale: 1, idiom: "tv"),
                ImageSpec(size: 128, scale: 2, idiom: "tv"),
                ImageSpec(size: 256, scale: 1, idiom: "tv"),
                ImageSpec(size: 256, scale: 2, idiom: "tv"),
            ]
        case .iPadOS:
            return [
                // iPad Notification (20pt)
                ImageSpec(size: 20, scale: 1, idiom: "ipad"),
                ImageSpec(size: 20, scale: 2, idiom: "ipad"),
                // iPad Settings (29pt)
                ImageSpec(size: 29, scale: 1, idiom: "ipad"),
                ImageSpec(size: 29, scale: 2, idiom: "ipad"),
                // iPad Spotlight (40pt)
                ImageSpec(size: 40, scale: 1, idiom: "ipad"),
                ImageSpec(size: 40, scale: 2, idiom: "ipad"),
                // iPad App (76pt)
                ImageSpec(size: 76, scale: 1, idiom: "ipad"),
                ImageSpec(size: 76, scale: 2, idiom: "ipad"),
                // iPad Pro App (83.5pt)
                ImageSpec(size: 83.5, scale: 2, idiom: "ipad"),
            ]
        }
    }
}

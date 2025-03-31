//
//  IrisetApp.swift
//  Iriset
//
//  Created by Zachary Bonner on 3/29/25.
//

import SwiftUI

@main
struct IrisetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
                .frame(minWidth: 400, minHeight: 300)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

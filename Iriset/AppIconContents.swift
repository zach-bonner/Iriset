//
//  AppIconContents.swift
//  Iriset
//
//  Created by Zachary Bonner on 3/29/25.
//

import Foundation

struct AppIconContents: Codable {
    let images: [[String: String]]
    let info: Info
    
    struct Info: Codable {
        let version: Int
        let author: String
    }
}

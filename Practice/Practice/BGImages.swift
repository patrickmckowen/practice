//
//  BGImages.swift
//  Practice
//
//  Created by Patrick McKowen on 10/1/20.
//

import Foundation

struct BackgroundImage: Codable, Identifiable {
    let id: Int
    let name: String
    let url: String
    let theme: String
}

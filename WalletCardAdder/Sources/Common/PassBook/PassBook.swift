//
//  PassBook.swift
//  WalletCardAdder
//
//  Created by 김상선 on 2018. 8. 26..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import Foundation

class PassBook : Codable, JSONable {
    var formatVersion: Int = 1
    var passTypeIdentifier: String = "pass.com.sungpyo"
    var teamIdentifier: String = "ABCDEFG123"
    var organizationName: String = "Sungpyo"
    var description: String?
    var foregroundColor: String?
    var backgroundColor: String?
    var logoText: String?
    
    private enum CodingKeys: String, CodingKey {
        case formatVersion
        case passTypeIdentifier
        case teamIdentifier
        case organizationName
        case description
        case foregroundColor
        case backgroundColor
        case logoText
    }
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        formatVersion = try container.decode(Int.self, forKey: .formatVersion)
        passTypeIdentifier = try container.decode(String.self, forKey: .passTypeIdentifier)
        teamIdentifier = try container.decode(String.self, forKey: .teamIdentifier)
        organizationName = try container.decode(String.self, forKey: .organizationName)
        description = try container.decode(String.self, forKey: .description)
        foregroundColor = try container.decode(String.self, forKey: .foregroundColor)
        backgroundColor = try container.decode(String.self, forKey: .backgroundColor)
        logoText = try container.decode(String.self, forKey: .logoText)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(formatVersion, forKey: .formatVersion)
        try container.encode(passTypeIdentifier, forKey: .passTypeIdentifier)
        try container.encode(teamIdentifier, forKey: .teamIdentifier)
        try container.encode(organizationName, forKey: .organizationName)
        try container.encode(description, forKey: .description)
        try container.encode(foregroundColor, forKey: .foregroundColor)
        try container.encode(backgroundColor, forKey: .backgroundColor)
        try container.encode(logoText, forKey: .logoText)
    }
}

extension PassBook {
    
    func foregroundColor(r: Int, g: Int, b: Int) {
        var r = r
        if (r > 256) {
            r = 0
        }
        
        var g = g
        if (g > 256) {
            g = 0
        }
        
        var b = b
        if (b > 256) {
            b = 0
        }
        foregroundColor = "rgb(\(r), \(g), \(b))"
    }
    
    func backgroundColor(r: Int, g: Int, b: Int) {
        var r = r
        if (r > 256) {
            r = 0
        }
        
        var g = g
        if (g > 256) {
            g = 0
        }
        
        var b = b
        if (b > 256) {
            b = 0
        }
        backgroundColor = "rgb(\(r), \(g), \(b))"
    }
}

//
//  PassJsonGenerator.swift
//  WalletCardAdder
//
//  Created by 김상선 on 2018. 8. 25..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import Foundation

let kFormatVersion = "formatVersion"
let kPassTypeIdentifier = "passTypeIdentifier"
let kTeamIdentifier = "teamIdentifier"
let kOrganizationName = "organizationName"
let kDescription = "description"
let kForegroundColor = "foregroundColor"
let kBackgroundColor = "backgroundColor"
let kLogoText = "logoText"
let kCoupon = "coupon"

class PassJsonBuilder : JsonBuilder {
    
    override init() {
        super.init()
        
        // pass.json에 고정으로 들어가는 내용
        self.contentDict[kFormatVersion] = 1
        self.contentDict[kPassTypeIdentifier] = "pass.com.blahblash"
        self.contentDict[kTeamIdentifier] = "ABCDEFG1234"
        self.contentDict[kOrganizationName] = "SungPyo"
        self.contentDict[kDescription] = "asdfasdfasdf"
    }
    
    static func build() -> PassJsonBuilder {
        return PassJsonBuilder()
    }
}

extension PassJsonBuilder {
    
    func formatVersion(_ formatVersion: Int) -> PassJsonBuilder {
        self.contentDict[kFormatVersion] = formatVersion
        return self
    }
    
    func foregroundColor(r: Int, g: Int, b: Int) -> PassJsonBuilder {
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
        self.contentDict[kForegroundColor] = "rgb(\(r), \(g), \(b))"
        return self
    }
    
    func backgroundColor(r: Int, g: Int, b: Int) -> PassJsonBuilder {
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
        self.contentDict[kBackgroundColor] = "rgb(\(r), \(g), \(b))"
        return self
    }
    
    func logoText(_ logoText: String) -> PassJsonBuilder {
        self.contentDict[kLogoText] = logoText
        return self
    }
    
    func coupon(_ coupon: CouponJsonBuilder) -> PassJsonBuilder {
        self.contentDict[kCoupon] = coupon.contentDict
        return self
    }
    
}

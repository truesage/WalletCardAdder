//
//  CouponJsonBuilder.swift
//  WalletCardAdder
//
//  Created by 김상선 on 2018. 8. 25..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import Foundation

let kPrimaryFields = "primaryFields"
let kAuxiliaryFields = "auxiliaryFields"

class CouponJsonBuilder : JsonBuilder {
    
    static func build() -> CouponJsonBuilder {
        return CouponJsonBuilder()
    }
}

extension CouponJsonBuilder {
    
    func primaryFields(_ primaryFields: [String:Any]) -> CouponJsonBuilder {
        self.contentDict[kPrimaryFields] = primaryFields
        return self
    }
    
    func primaryFields(key: Any, label: Any, value: Any) -> CouponJsonBuilder {
        var fields = [String: Any]()
        fields["key"] = key
        fields["label"] = label
        fields["value"] = value
        self.contentDict[kPrimaryFields] = fields
        return self
    }
    
    func auxiliaryFields(_ auxiliaryFields: [String:Any]) -> CouponJsonBuilder {
        self.contentDict[kAuxiliaryFields] = auxiliaryFields
        return self
    }
    
    func auxiliaryFields(key: Any, label: Any, value: Any, isRelative: Any, dateStyle: Any) -> CouponJsonBuilder {
        var fields = [String: Any]()
        fields["key"] = key
        fields["label"] = label
        fields["value"] = value
        fields["isRelative"] = isRelative
        fields["dateStyle"] = dateStyle
        self.contentDict[kAuxiliaryFields] = fields
        return self
    }
}

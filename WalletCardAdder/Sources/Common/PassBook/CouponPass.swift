//
//  CouponPass.swift
//  playground
//
//  Created by 김상선 on 2018. 8. 26..
//  Copyright © 2018년 김상선. All rights reserved.
//

import Foundation

class CouponPass: PassBook {
    
    class CouponPassField: Codable {
        var key: String?
        var label: String?
        var value: String? // TODO: change 'Any' Type
        var isRelative: Bool?
        var dateStyle: String?
        
        init() {
        }
    }
    
    var primaryFields: CouponPassField?
    var auxiliaryFields: CouponPassField?
    
    private enum CodingKeys: String, CodingKey {
        case primaryFields
        case auxiliaryFields
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        primaryFields = try container.decode(CouponPassField.self, forKey: .primaryFields)
        auxiliaryFields = try container.decode(CouponPassField.self, forKey: .auxiliaryFields)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(primaryFields, forKey: .primaryFields)
        try container.encode(auxiliaryFields, forKey: .auxiliaryFields)
        try super.encode(to: encoder)
    }
}

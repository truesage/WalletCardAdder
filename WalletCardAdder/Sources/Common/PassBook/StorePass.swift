//
//  StorePass.swift
//  WalletCardAdder
//
//  Created by 김상선 on 2018. 8. 26..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import Foundation

class StorePass: PassBook {
    
    class StorePassField: Codable {
        var key: String?
        var label: String?
        var value: Int? 
        var currencyCode: String?
        
        init() {
        }
    }
    
    var primaryFields: StorePassField?
    var auxiliaryFields: StorePassField?
    
    private enum CodingKeys: String, CodingKey {
        case primaryFields
        case auxiliaryFields
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        primaryFields = try container.decode(StorePassField.self, forKey: .primaryFields)
        auxiliaryFields = try container.decode(StorePassField.self, forKey: .auxiliaryFields)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(primaryFields, forKey: .primaryFields)
        try container.encode(auxiliaryFields, forKey: .auxiliaryFields)
        try super.encode(to: encoder)
    }
}

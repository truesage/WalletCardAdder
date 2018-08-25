//
//  Barcode.swift
//  WalletCardAdder
//
//  Created by 김상선 on 2018. 8. 26..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import Foundation

enum BarcodeFormat: String, Codable {
    case QR = "PKBarcodeFormatQR"
    case PDF417 = "PKBarcodeFormatPDF417"
    case Aztec = "PKBarcodeFormatAztec"
}

class Barcode : Codable {
    var message: String?
    var format: BarcodeFormat?
    var messageEncoding: String = "iso-8859-1"
    
    private enum CodingKeys: String, CodingKey {
        case message
        case format
        case messageEncoding
    }
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(String.self, forKey: .message)
        format = try container.decode(BarcodeFormat.self, forKey: .format)
        messageEncoding = try container.decode(String.self, forKey: .messageEncoding)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        try container.encode(format, forKey: .format)
        try container.encode(messageEncoding, forKey: .messageEncoding)
    }
}

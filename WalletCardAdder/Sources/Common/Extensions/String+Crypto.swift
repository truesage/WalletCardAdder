//
//  String+.swift
//  WalletCardAdder
//
//  Created by JSP_MacBookPro on 2018. 8. 25..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import Foundation

extension String {
    /// SHA1 해시 데이터 반환.
    ///
    /// - Returns: String
    func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}

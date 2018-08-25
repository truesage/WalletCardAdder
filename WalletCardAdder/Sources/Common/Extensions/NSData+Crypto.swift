//
//  NSData+Crypto.swift
//  WalletCardAdder
//
//  Created by 김상선 on 2018. 8. 26..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import Foundation

extension Data {
    /// SHA1 해시 데이터 반환.
    ///
    /// - Returns: String
    func sha1() -> String {
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        self.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(self.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}

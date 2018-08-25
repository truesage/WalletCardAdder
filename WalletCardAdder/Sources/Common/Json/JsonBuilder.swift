//
//  JsonBuilder.swift
//  WalletCardAdder
//
//  Created by 김상선 on 2018. 8. 25..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import Foundation

class JsonBuilder {
    
    var contentDict: [String:Any]
    
    init() {
        self.contentDict = [:]
    }
    
    private func toString(dict: [String:Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func toJsonString() -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self.contentDict, options: .prettyPrinted)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func toFile(filename: String, directory: String) {
        // json파일을 Document 밑의 지정한 디렉토리에 생성한다
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            // 디렉토리가 존재하지 않으면 생성
            let fileDirURL = dir.appendingPathComponent(directory)
            if !FileManager.default.fileExists(atPath: fileDirURL.path) {
                do {
                    try FileManager.default.createDirectory(at: fileDirURL, withIntermediateDirectories: false, attributes: nil)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            // json string을 해당위치에 파일로 저장
            let fileURL = fileDirURL.appendingPathComponent(filename)
            do {
                if let jsonStr = self.toJsonString() {
                    try jsonStr.write(to: fileURL, atomically: false, encoding: .utf8)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

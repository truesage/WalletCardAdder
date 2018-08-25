//
//  ManifestJSON.swift
//  WalletCardAdder
//
//  Created by 김상선 on 2018. 8. 26..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import Foundation

class ManifestJSON {
    private var contentDict: [String:String]
    
    init() {
        self.contentDict = [String:String]()
    }
    
    func append(directory: String, filename: String) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(directory).appendingPathComponent(filename)
            
            let data: Data? = try? Data(contentsOf: fileURL)
            if let data = data {
                self.contentDict[filename] = data.sha1()
            } else {
                print("append failed : \(filename)")
            }
        }
    }
    
    func toJSONString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let json = try? encoder.encode(contentDict)
        
        if let jsonData = json, let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        
        return nil
    }
    
    func toFile(directory: String) {
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
            let fileURL = fileDirURL.appendingPathComponent("manifest.json")
            do {
                if let jsonStr = self.toJSONString() {
                    try jsonStr.write(to: fileURL, atomically: false, encoding: .utf8)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

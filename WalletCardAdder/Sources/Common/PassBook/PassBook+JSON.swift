//
//  PassBook+JSON.swift
//  playground
//
//  Created by 김상선 on 2018. 8. 26..
//  Copyright © 2018년 김상선. All rights reserved.
//

import Foundation

protocol JSONable { }

extension JSONable where Self: PassBook {
    
    func toJSONString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let json = try? encoder.encode(self)
        
        if let jsonData = json, let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
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
            let fileURL = fileDirURL.appendingPathComponent("\(filename).json")
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

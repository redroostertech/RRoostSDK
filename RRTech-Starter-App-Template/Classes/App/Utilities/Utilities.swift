//
//  Utilities.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation
import UIKit

public class Utilities {

    static func savePermanentString( keyName: String, keyValue: String) {
        print("setting internally: \(keyName) as \(keyValue)")
        UserDefaults.standard.set(keyValue, forKey: keyName)
    }
    
    static func getThreadInfo() {
        print("Retrieve Key fetch is running on = \(Thread.isMainThread ? "Main Thread" : "Background Thread")")
    }
    
    static func getPermanentString(keyName: String) -> String {
        print("getting \(keyName)")
        if let userIDString =  UserDefaults.standard.object(forKey: keyName) as? String {
            return userIDString
        } else {
            return ""
        }
    }

    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    static func deleteFile(path: NSURL) -> Bool {
        var deleted = true
        if (FileManager.default.fileExists(atPath: path.path!)) {
            do {
                try FileManager.default.removeItem(atPath: path.path!)
            } catch {
                deleted = false
            }
        }
        return deleted
    }
    
    static func localizedString(forKey key: String, fromFile file: String = "Localizable") -> String {
        var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        if result == key {
            result = Bundle.main.localizedString(forKey: key, value: nil, table: file)
        }
        return result
    }
    
    static func numberToMoney(number: Double, identifier: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: identifier)
        return formatter.string(from: number as NSNumber)!
    }
}


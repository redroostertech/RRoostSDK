//
//  Utilities.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation
import UIKit

public enum FileType: String {
  case json = "json"
}

public class Utilities {

    public static func getThreadInfo() {
        print("Retrieve Key fetch is running on = \(Thread.isMainThread ? "Main Thread" : "Background Thread")")
    }

    public static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    public static func deleteFile(path: NSURL) -> Bool {
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
    
    public static func localizedString(forKey key: String, fromFile file: String = "Localizable") -> String {
        var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        if result == key {
            result = Bundle.main.localizedString(forKey: key, value: nil, table: file)
        }
        return result
    }
    
    public static func numberToMoney(number: Double, identifier: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: identifier)
        return formatter.string(from: number as NSNumber)!
    }

  public static func getFileSystemResource(fileName: String, ofFileType type: FileType) -> [String: Any]? {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: type.rawValue) else { return nil }
    do {
      let jsonData = try Data(contentsOf: url)
      let json = try JSONSerialization.jsonObject(with: jsonData) as! [String:Any]
      return json
    }
    catch {
      print(error)
      return nil
    }
  }
}


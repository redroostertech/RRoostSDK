//
//  Dictionary+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation

public extension Dictionary {
    /**
     Build string representation of HTTP parameter dictionary of keys and objects.
     This percent escapes in compliance with RFC 3986.
     http://www.ietf.org/rfc/rfc3986.txt
     
     - Returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
     */
    
//    func stringFromHttpParameters() -> String {
//        let parameterArray = self.map { (key, value) -> String in
//            let percentEscapedKey = ((key as? String) ?? "").stringByAddingPercentEncodingForURLQueryValue()!
//            let percentEscapedValue = ((value as? String) ?? "").stringByAddingPercentEncodingForURLQueryValue()!
//            return "\(percentEscapedKey)=\(percentEscapedValue)"
//        }
//
//        return parameterArray.joined(separator: "&")
//    }
    
  func toJsonString() -> String? {
    return toString(object: self)
  }

//    func sortedKeys(isOrderedBefore:(Key,Key) -> Bool) -> [Key] {
//        var array = Array(self.keys)
//        return array.sort(by: isOrderedBefore)
//    }

    // Slower because of a lot of lookups, but probably takes less memory (this is equivalent to Pascals answer in an generic extension)
//    func sortedKeysByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
//        return sortedKeys {
//            isOrderedBefore(self[$0]!, self[$1]!)
//        }
//    }

    // Faster because of no lookups, may take more memory because of duplicating contents
//    func keysSortedByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
//        var array = Array(self)
//        return array.sort() {
//                let (_, lv) = $0
//                let (_, rv) = $1
//                return isOrderedBefore(lv, rv)
//            }
//            .map {
//                let (k, _) = $0
//                return k
//        }
//    }
}

public extension NSDictionary {
  func toJsonString() -> String? {
    return toString(object: self)
  }
}

private func toString(object: Any) -> String? {
  guard JSONSerialization.isValidJSONObject(object), let data = try? JSONSerialization.data(withJSONObject: object) else {
    return nil
  }
  return String(data: data, encoding: .utf8)
}

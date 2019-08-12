//
//  CustomStringConvertible+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation

public extension CustomStringConvertible {
  var description : String {
    var description: String = "***** \(type(of: self)) *****\n"
    let selfMirror = Mirror(reflecting: self)
    for child in selfMirror.children {
        if let propertyName = child.label {
            description += "\(propertyName): \(child.value)\n"
        }
    }
    return description
  }
}

public extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
        throw NSError()
    }
    return dictionary
  }
}

public extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}

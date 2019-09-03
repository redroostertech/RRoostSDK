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

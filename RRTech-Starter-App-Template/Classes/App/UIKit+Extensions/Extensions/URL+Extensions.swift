//
//  NSURL+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation

public extension NSURL {
  var baseDomain: String? {
    return host?.components(separatedBy: ".").suffix(2).joined(separator: ".")
  }
}

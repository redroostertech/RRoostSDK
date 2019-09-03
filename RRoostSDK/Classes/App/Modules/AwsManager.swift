//
//  AWSInitializer.swift
//  RRTech-Starter-App-Template
//
//  Created by Michael Westbrooks on 8/14/19.
//

import Foundation

public struct AWSCredentials {
  var identityPool: String?
}

public protocol AWSServiceManager {
  func initialize(credentials: AWSCredentials)
}

//
//  Comment+Interface.swift
//  ChameleonFramework
//
//  Created by Michael Westbrooks on 9/1/19.
//

import Foundation

public protocol BaseComment {
  var id: String { get set }
  var text: String { get set }
  func retrieveOwnerName() -> String
  func retrieveOwnerImage() -> String
  func retrieveLikeCount() -> Int
}

extension BaseComment {
  func retrieveOwnerName() -> String { return "" }
  func retrieveOwnerImage() -> String { return "" }
  func retrieveLikeCount() -> Int { return 0 }
}

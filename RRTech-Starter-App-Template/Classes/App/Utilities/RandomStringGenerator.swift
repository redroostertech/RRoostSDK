//
//  RandomStringGenerator.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation
import UIKit

/**
 `RanStringGen` generates a random string value
 */
public class RanStringGen: NSObject {

    private var len: Int
    private let genCharacters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")

    init(length: Int) {
        len = length
    }
    
    public func returnString() -> String {
        var returnString = ""
        for _ in 0..<len {
            // Generate a random index based on your array of characters count
            let rand = arc4random_uniform(UInt32(genCharacters.count))
            // Append the random character to your string
            returnString.append(genCharacters[Int(rand)])
        }
        return returnString
    }
}

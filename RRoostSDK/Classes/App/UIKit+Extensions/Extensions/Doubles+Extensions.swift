//
//  Double+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation

public extension Double {
  func cleanValue(maxDecimal: Int = 2, minDecimal: Int? = nil, withCommas: Bool = true) -> String {

    let inputNumber = self

    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = NumberFormatter.Style.decimal
    numberFormatter.maximumFractionDigits = maxDecimal
    if minDecimal != nil {
      numberFormatter.minimumFractionDigits = minDecimal!
      if minDecimal! > maxDecimal {
          numberFormatter.maximumFractionDigits = minDecimal!
      }
    }

    let formattedValue = numberFormatter.string(from: inputNumber as NSNumber)!
    let formattedValueNoCommas = formattedValue.replacingOccurrences(of: ",", with: "")

    switch withCommas {
    case true:
      return formattedValue
    case false:
      return formattedValueNoCommas
    }
  }

  /// Rounds the double to decimal places value
  func rounded(toPlaces places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}

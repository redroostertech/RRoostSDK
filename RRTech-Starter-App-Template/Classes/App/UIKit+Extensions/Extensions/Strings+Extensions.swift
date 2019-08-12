//
//  Strings+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation
import UIKit

public extension String {
  var parseJSONString: [String: AnyObject]? {
      let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
      if let jsonData = data {
          do {
              return try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: AnyObject]
          } catch let error as NSError {
              print(error)
          }
          return nil
      }
      return nil
  }

  var isBlank: Bool {
      get {
          let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
          return trimmed.isEmpty
      }
  }
  var djb2hash: Int {
      let unicodeScalars = self.unicodeScalars.map { $0.value }
      return unicodeScalars.reduce(5381) {
          ($0 << 5) &+ $0 &+ Int($1)
      }
  }

  var sdbmhash: Int {
      let unicodeScalars = self.unicodeScalars.map { $0.value }
      return unicodeScalars.reduce(0) {
          Int($1) &+ ($0 << 6) &+ ($0 << 16) - $0
      }
  }

  var isEmail: Bool {
      do {
          let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
          return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
      } catch {
          return false
      }
  }

  var isAlphanumeric: Bool {
      return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
  }

  var isValidPassword: Bool {
      do {
          let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
          if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil){

              if (self.count>=6 && self.count <= 20) {
                  return true
              } else {
                  return false
              }
          } else {
              return false
          }
      } catch {
          return false
      }
  }

  var isPhoneNumber: Bool {
      do {
          let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
          let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
          if let res = matches.first {
              return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
          } else {
              return false
          }
      } catch {
          return false
      }
  }

  var html2Attributed: NSAttributedString? {
      do {
          guard let data = data(using: String.Encoding.utf8) else {
              return nil
          }
          return try NSAttributedString(data: data,
                                        options: [.documentType: NSAttributedString.DocumentType.html,
                                                  .characterEncoding: String.Encoding.utf8.rawValue],
                                        documentAttributes: nil)
      } catch {
          print("error: ", error)
          return nil
      }
  }

  var htmlAttributed: (NSAttributedString?, NSDictionary?) {
      do {
          guard let data = data(using: String.Encoding.utf8) else {
              return (nil, nil)
          }

          var dict:NSDictionary?
          dict = NSMutableDictionary()

          return try (NSAttributedString(data: data,
                                         options: [.documentType: NSAttributedString.DocumentType.html,
                                                   .characterEncoding: String.Encoding.utf8.rawValue],
                                         documentAttributes: &dict), dict)
      } catch {
          print("error: ", error)
          return (nil, nil)
      }
  }

  var westernArabicNumeralsOnly: String {
    let pattern = UnicodeScalar("0")..."9"
    return String(unicodeScalars.compactMap { pattern ~= $0 ? Character($0) : nil })
  }

  static func className(_ aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).components(separatedBy: ".").last!
  }

  static func getFormattedDate(date:Date, dateFormat:String) ->String{
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = dateFormat //"MM/dd/yy h:mm a Z"
    let strFormattedDate = dateformatter.string(from: date)
    return strFormattedDate
  }

  static func getDateFromString(strDate:String, dateFormat:String) ->Date{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat //"MM/dd/yy h:mm a Z"
    dateFormatter.locale = Locale.init(identifier: "en_GB")
    let dateObj = dateFormatter.date(from: strDate)
    return dateObj!
  }
}

public extension String {
  func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
    return ceil(boundingBox.width)
  }

  func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
    return ceil(boundingBox.height)
  }

  func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
    return ceil(boundingBox.width)
  }

  func isEmptyTrimmingSpaces() -> Bool {
    return self.trimmingCharacters(in: CharacterSet(charactersIn: " ")).isEmpty
  }

  func className(_ aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).components(separatedBy: ".").last!
  }

  func startsWith(string: String) -> Bool {
    guard let range = range(of: string, options:[.caseInsensitive]) else {
      return false
    }
    return range.lowerBound == startIndex
  }

  func substring(_ from: Int) -> String {
    return self.substring(from: self.index(self.startIndex, offsetBy: from))
  }

  func equalsIgnoreCase(str:String)->Bool{
    var isEqual:Bool = false
    if (self.caseInsensitiveCompare(str) == ComparisonResult.orderedSame) {
      isEqual = true
    }
    return isEqual
  }

  func toDate(_ format: CustomDateFormat = .timeDate) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format.rawValue
    return dateFormatter.date(from: self) ?? Date()
  }

  func convertHtml() -> NSAttributedString {

    guard let data = data(using: .utf8) else {
      return NSAttributedString()
    }

    do {

      return try NSAttributedString(data: data,
                                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
                                    documentAttributes: nil)
    } catch {
      return NSAttributedString()
    }
  }
  //    func htmlAttributed(using font: UIFont, color: UIColor) -> NSAttributedString? {
  //        do {
  //            let htmlCSSString = "<style>" +
  //                "html *" +
  //                "{" +
  //                "font-size: \(font.pointSize)pt !important;" +
  //                "color: #\(color.hexValue()) !important;" +
  //                "font-family: \(font.familyName), Helvetica !important;" +
  //            "}</style> \(self)"
  //
  //            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
  //                return nil
  //            }
  //
  //            return try NSAttributedString(data: data,
  //                                          options: [.documentType: NSAttributedString.DocumentType.html,
  //                                                    .characterEncoding: String.Encoding.utf8.rawValue],
  //                                          documentAttributes: nil)
  //        } catch {
  //            print("error: ", error)
  //            return nil
  //        }
  //    }

  //    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {
  //        do {
  //            let htmlCSSString = "<style>" +
  //                "html *" +
  //                "{" +
  //                "font-size: \(size)pt !important;" +
  //                "color: #\(color.hexValue()) !important;" +
  //                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
  //            "}</style> \(self)"
  //
  //            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
  //                return nil
  //            }
  //
  //            return try NSAttributedString(data: data,
  //                                          options: [.documentType: NSAttributedString.DocumentType.html,
  //                                                    .characterEncoding: String.Encoding.utf8.rawValue],
  //                                          documentAttributes: nil)
  //        } catch {
  //            print("error: ", error)
  //            return nil
  //        }
  //    }
}

/*
 1. getLocalizedTextFor method reads from Localizable.strings
 file of the given module
 2. getTextFor method reads from the ModuleName.strings file
 which should be used when localizable string value are
 same across different targets
 */

extension String {
//    public static func getLocalizedTextFor(key: String, module: String = DeltaUIKitModule.name) -> String {
//        return getLocalizedText(key: key, module: module)
//    }
//
//    public static func getTextFor(key: String, module: String = DeltaUIKitModule.name) -> String {
//        return getText(key: key, module: module)
//    }
}

extension NSString {
//    @objc public static func getLocalizedTextFor(key: String, module: String = DeltaUIKitModule.name) -> String {
//        return getLocalizedText(key: key, module: module)
//    }
//
//    @objc public static func getTextFor(key: String, module: String = DeltaUIKitModule.name) -> String {
//        return getText(key: key, module: module)
//    }
}

//private func getLocalizedText(key: String, module: String) -> String {
//    if let bundle = Bundle(identifier: DeltaUIKitModule.defaultModule.moduleBundleMap.getBundleIdentifier(module: module)) {
//        return bundle.localizedString(forKey: key, value: "", table: nil)
//    }
//    return key
//}
//
//private func getText(key: String, module: String) -> String {
//    if let bundle = Bundle(identifier: DeltaUIKitModule.defaultModule.moduleBundleMap.getBundleIdentifier(module: module)) {
//        return bundle.localizedString(forKey: key, value: "", table: module)
//    }
//    return key
//}

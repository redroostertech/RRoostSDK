//
//  NSMutableAttributedString+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation
import UIKit

public extension NSMutableAttributedString {

  func makeBold(_ text: String, ofSize size: CGFloat) -> NSMutableAttributedString {
    let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: size)]
      let boldString = NSMutableAttributedString(string:text, attributes: attrs)
      append(boldString)
      return self
  }

  func makeBold(usingFont font: UIFont, forText text: String) -> NSMutableAttributedString {
    let attrs: [NSAttributedString.Key: Any] = [.font: font]
      append(text: text, andAttributes: attrs)
      return self
  }

  func makeNormal(_ text:String, ofSize size: CGFloat)->NSMutableAttributedString {
    let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: size)]
      append(text: text, andAttributes: attrs)
      return self
  }

  func makeNormal(usingFont font: UIFont, forText text: String) -> NSMutableAttributedString {
    let attrs: [NSAttributedString.Key: Any] = [.font: font]
      append(text: text, andAttributes: attrs)
      return self
  }
      
  func makeWithColor(_ text: String, color: UIColor) -> NSMutableAttributedString {
    let attrs = [NSAttributedString.Key.foregroundColor: color]
      append(text: text, andAttributes: attrs)
      return self
  }
    
  private func append(text: String, andAttributes attrs: [NSAttributedString.Key: Any]){
      let string = NSMutableAttributedString(string:text, attributes: attrs)
      append(string)
  }
    
  func addImage(_ image: String, andFont font: UIFont) {
    if let image = UIImage(named: image) {
      let attachment = NSTextAttachment()
      attachment.image = image
      let imageAspectRatio = image.size.width / image.size.height
      let imageHeight = CGFloat(UIDevice().modelName.contains("iPad") ? 18: 11)
      let imageWidth = imageHeight * imageAspectRatio
      attachment.bounds = CGRect(x: 0.0,
                                 y: font.descender,
                                 width: imageWidth,
                                 height: imageHeight)
      let statusWithAttachment = NSAttributedString(attachment: attachment)
      self.append(statusWithAttachment)
    }
  }

  func addImageFromString(_ image: String, andFont font: UIFont) {
    if let image = UIImage(named: image) {
      let attachment = NSTextAttachment()
      attachment.image = image
      let imageAspectRatio = image.size.width / image.size.height
      let imageHeight = CGFloat(UIDevice().modelName.contains("iPad") ? 18: 11)
      let imageWidth = imageHeight * imageAspectRatio
      attachment.bounds = CGRect(x: 0.0,
                                 y: font.descender,
                                 width: imageWidth,
                                 height: imageHeight)
      let statusWithAttachment = NSAttributedString(attachment: attachment)
      self.append(statusWithAttachment)
    }
  }
}

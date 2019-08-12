//
//  UILabel+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation
import UIKit

public extension UILabel {
  func resizeAccordingToString() -> Void {
    guard let text = self.text else {
        return
    }
    self.frame.size.height = text.height(withConstrainedWidth: kWidthOfScreen,
                                         font: .systemFont(ofSize: 14.0))
  }

  func makeOneLine() {
    self.numberOfLines = 1
    self.lineBreakMode = .byTruncatingTail
  }

  func makeMultipleLines(_ max: Int = 0) {
    self.numberOfLines = max
    self.lineBreakMode = .byWordWrapping
  }

  func makeTitleCase() {
    self.text = self.text?.capitalized
  }

  func set(text: String, lineSpacing: CGFloat) {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    let attrString = NSMutableAttributedString(string: text)
    attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
    self.attributedText = attrString
  }
}

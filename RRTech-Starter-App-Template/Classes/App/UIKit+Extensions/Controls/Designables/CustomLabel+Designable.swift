//
//  CustomLabel+Designable.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation
import UIKit

@IBDesignable
public class CustomLabel: UILabel {
  @IBInspectable var topInset: CGFloat = 15.0
  @IBInspectable var bottomInset: CGFloat = 15.0
  @IBInspectable var leftInset: CGFloat = 15.0
  @IBInspectable var rightInset: CGFloat = 15.0

  override public func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
  }

  override public var intrinsicContentSize: CGSize {
    var contentSize = super.intrinsicContentSize
    contentSize.height += topInset + bottomInset
    contentSize.width += leftInset + rightInset
    return contentSize
  }
}

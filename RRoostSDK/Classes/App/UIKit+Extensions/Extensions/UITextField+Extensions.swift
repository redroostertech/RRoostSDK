//
//  UITextField+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import UIKit

public extension UITextField {
  @IBInspectable var placeHolderColor: UIColor? {
    get {
        return self.placeHolderColor
    }
    set {
      self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
    }
  }

  func addLeftPadding(withWidth width: CGFloat) {
    let padding = UIView(frame: CGRect(x: 0,
                                       y: 0,
                                       width: width,
                                       height: self.bounds.height))
    self.leftView = padding
    self.leftViewMode = .always
  }

  func addRightPadding(withWidth width: CGFloat) {
    let padding = UIView(frame: CGRect(x: 0,
                                       y: 0,
                                       width: width,
                                       height: self.bounds.height))
    self.rightView = padding
    self.rightViewMode = .always
  }

  func addHorizontalLine(_ sender: UITextField) {
    let horizontalLine = UIView(frame: CGRect(x: sender.frame.origin.x , y: sender.frame.maxY - 5, width: sender.frame.width, height: 1))
    horizontalLine.backgroundColor = .black
    horizontalLine.layer.zPosition = 1000
    sender.addSubview(horizontalLine)

    print("Size of UIElement \(sender)")
    print(sender.frame.width)
  }

  func setLeftViewButton(icon: UIImage)->UIButton {
    let btnView = UIButton(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) * 0.70), height: ((self.frame.height) * 0.70)))
    btnView.setImage(icon, for: .normal)
    btnView.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
    self.leftViewMode = .always
    self.leftView = btnView
    return btnView
  }

  func setDelegate(delegate: UITextFieldDelegate) {
    self.delegate = delegate
  }

  func secureTextEntryCheck() {
    if self.isSecureTextEntry {
      self.isSecureTextEntry = false
    } else {
      self.isSecureTextEntry = true
    }
  }
}

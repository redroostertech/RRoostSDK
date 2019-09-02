//
//  UITableView+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation
import UIKit

public extension UITableView {
  
  func setEmptyMessage(_ message: String) {
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    messageLabel.text = message
    messageLabel.textColor = .black
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = .center;
    messageLabel.font = UIFont(name: kFontBody, size: 15)
    messageLabel.sizeToFit()

    self.backgroundView = messageLabel;
    self.separatorStyle = .none;
  }

  func restore() {
    self.backgroundView = nil
    self.separatorStyle = .singleLine
  }

  func scrollToTop(completion: @escaping () -> Void) {
    DispatchQueue.main.async {
      if self.visibleCells.count > 0 {
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
      }
      completion()
    }
  }

  func scrollToBottom(completion: (() -> Void)? = nil) {
    DispatchQueue.main.async {
      if self.numberOfRows(inSection: 0) > 0 {
        self.scrollToRow(at: IndexPath(row: self.numberOfRows(inSection: 0) - 1, section: 0), at: .bottom, animated: true)
      }
      completion?()
    }
  }

  func registerNib(withNibName nibName: String, forReuseIdentifier identifier: String) {
    let nib = UINib(nibName: nibName, bundle: nil)
    self.register(nib, forCellReuseIdentifier: identifier)
  }

  func getNib() -> UINib? {
    let podBundle = Bundle(for: SFMapsServices.self)
    guard let bundleURL = podBundle.url(forResource: "forcemaps-ios", withExtension: "bundle") else { return nil }
    return UINib(nibName: String(describing: self), bundle: Bundle(url: bundleURL))
  }

  func getIdentifier() -> String {
    return String(describing: self)
  }
}

public extension UITableViewCell {
  static var nib: UINib {
    return UINib(nibName: self.identifier, bundle: nil)
  }
}

public extension UICollectionReusableView {
  static var nib: UINib {
    return UINib(nibName: self.identifier, bundle: nil)
  }
}

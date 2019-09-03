//
//  UIButton+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation
import UIKit

public extension UIButton {

    func makeCircular() {
        self.applyCornerRadius()
    }
    
    func setBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
    func setText(_ text: String) {
        self.setTitle(text, for: .normal)
    }
    
    func setWhiteText() {
        self.setTitleColor(.white,
                           for: .normal)
    }
    
    func setBlackText() {
        self.setTitleColor(UIColor.AppColors.softBlack,
                           for: .normal)
    }
    
    func setTextColor(_ color: UIColor) {
        self.setTitleColor(color, for: .normal)
    }
    
    func setEmpty() {
        self.setText("")
    }
    
    func removeImages() {
        self.setImage(nil, for: .normal)
        self.setBackgroundImage(nil, for: .normal)
    }
    
    func updateImageWithSize(_ imageSize: CGSize) {
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
        let buttonSize = self.frame.size
        let yInset = (buttonSize.height - imageSize.height) / 2
        let xInset = (buttonSize.width - imageSize.width) / 2
        self.imageEdgeInsets = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
    }

    func setTitleWithAttributes(_ text: String?, withColor color: UIColor) {
        if let text = text {
            self.setText(text)
            self.setTitleColor(color, for: .normal)
        }
    }
}

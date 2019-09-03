//
//  UIImageView+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation
import UIKit
import ImageIO

public let imageCache = NSCache <AnyObject,AnyObject>()

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// MARK: - UIImageView
public extension UIImageView {
  func makeCircular() {
    self.applyCornerRadius()
  }

  func makeAspectFill() {
    self.contentMode = .scaleAspectFill
  }

  func makeAspectFit() {
    self.contentMode = .scaleAspectFit
  }

  func setImage(name: String) {
    self.image = UIImage.getImage(name: name)
  }

  func setImage(image: UIImage) {
    self.image = image
  }

func imageFromUrl(theUrl: String) {
  self.image = nil

  //check cache for image
  if let cachedImage = imageCache.object(forKey: theUrl as AnyObject) as? UIImage{
    self.image = cachedImage
    return
  }

  //otherwise download it
  let url = URL(string: theUrl)
  URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
    if (error != nil) {
      print(error!)
      return
    }

    DispatchQueue.main.async(execute: {
      if let downloadedImage = UIImage(data: data!) {
        imageCache.setObject(downloadedImage, forKey: theUrl as AnyObject)
        self.image = downloadedImage
      }
    })
  }).resume()
}

}

//  MARK:- Extensions for UIImage
public extension UIImage {
  func maskWithColor(color: UIColor) -> UIImage? {
    let maskImage = cgImage!

    let width = size.width
    let height = size.height
    let bounds = CGRect(x: 0, y: 0, width: width, height: height)

    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

    context.clip(to: bounds, mask: maskImage)
    context.setFillColor(color.cgColor)
    context.fill(bounds)

    if let cgImage = context.makeImage() {
      let coloredImage = UIImage(cgImage: cgImage)
      return coloredImage
    } else {
      return nil
    }
  }

  @objc class func imageFromColor(_ color: UIColor) -> UIImage {
    let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context: CGContext = UIGraphicsGetCurrentContext()!
    context.setFillColor(color.cgColor)
    context.fill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
  }
    
    class func getImage(name: String) -> UIImage {
        return UIImage(named: name)!
    }

    func resizedImage(newSize: CGSize) -> UIImage {
        guard self.size != newSize else { return self }

        let originRatio = self.size.width / self.size.height
        let newRatio = newSize.width / newSize.height
        var size: CGSize = .zero

        if originRatio < newRatio {
            size.height = newSize.height
            size.width = newSize.height * originRatio
        } else {
            size.width = newSize.width
            size.height = newSize.width / originRatio
        }

        let scale: CGFloat = UIScreen.main.scale
        size.width /= scale
        size.height /= scale
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    func makeCentrallyAlignedCompositeImage(_ superImposeImage: UIImage, scaleInParts: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scale = (floor(scaleInParts / 2))/scaleInParts
        let width = size.width
        let height = size.height
        let compositeImageRect = CGRect(x: width*scale, y: height*scale, width: width/scaleInParts, height: height/scaleInParts)
        superImposeImage.draw(in: compositeImageRect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }

    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    var circleMasked: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func squareImage() -> UIImage {
        let image = self
        let originalWidth  = image.size.width
        let originalHeight = image.size.height
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        var edge: CGFloat = 0.0

        if (originalWidth > originalHeight) {
            // landscape
            edge = originalHeight
            x = (originalWidth - edge) / 2.0
            y = 0.0

        } else if (originalHeight > originalWidth) {
            // portrait
            edge = originalWidth
            x = 0.0
            y = (originalHeight - originalWidth) / 2.0
        } else {
            // square
            edge = originalWidth
        }

        let cropSquare = CGRect(x:x, y:y, width:edge, height:edge)

        let imageRef = image.cgImage!.cropping(to: cropSquare)

        return UIImage(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: image.imageOrientation)
    }

    func resize(withWidth newWidth: CGFloat) -> UIImage? {

        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

  class func gifImageWithData(_ data: Data) -> UIImage? {
    guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
      print("image doesn't exist")
      return nil
    }
    return UIImage.animatedImageWithSource(source)
  }

  class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
    guard let bundleURL = URL(string: gifUrl)
      else {
        print("image named \"\(gifUrl)\" doesn't exist")
        return nil
    }
    guard let imageData = try? Data(contentsOf: bundleURL) else {
      print("image named \"\(gifUrl)\" into NSData")
      return nil
    }

    return gifImageWithData(imageData)
  }

  class func gifImageWithName(_ name: String) -> UIImage? {
    guard let bundleURL = Bundle.main
      .url(forResource: name, withExtension: "gif") else {
        print("SwiftGif: This image named \"\(name)\" does not exist")
        return nil
    }
    guard let imageData = try? Data(contentsOf: bundleURL) else {
      print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
      return nil
    }

    return gifImageWithData(imageData)
  }

  class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
    var delay = 0.1

    let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
    let gifProperties: CFDictionary = unsafeBitCast(
      CFDictionaryGetValue(cfProperties,
                           Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
      to: CFDictionary.self)

    var delayObject: AnyObject = unsafeBitCast(
      CFDictionaryGetValue(gifProperties,
                           Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
      to: AnyObject.self)
    if delayObject.doubleValue == 0 {
      delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                       Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
    }

    delay = delayObject as! Double

    if delay < 0.1 {
      delay = 0.1
    }

    return delay
  }

  class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
    var a = a
    var b = b
    if b == nil || a == nil {
      if b != nil {
        return b!
      } else if a != nil {
        return a!
      } else {
        return 0
      }
    }

    if a < b {
      let c = a
      a = b
      b = c
    }

    var rest: Int
    while true {
      rest = a! % b!

      if rest == 0 {
        return b!
      } else {
        a = b
        b = rest
      }
    }
  }

  class func gcdForArray(_ array: Array<Int>) -> Int {
    if array.isEmpty {
      return 1
    }

    var gcd = array[0]

    for val in array {
      gcd = UIImage.gcdForPair(val, gcd)
    }

    return gcd
  }

  class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
    let count = CGImageSourceGetCount(source)
    var images = [CGImage]()
    var delays = [Int]()

    for i in 0..<count {
      if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
        images.append(image)
      }

      let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                      source: source)
      delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
    }

    let duration: Int = {
      var sum = 0

      for val: Int in delays {
        sum += val
      }

      return sum
    }()

    let gcd = gcdForArray(delays)
    var frames = [UIImage]()

    var frame: UIImage
    var frameCount: Int
    for i in 0..<count {
      frame = UIImage(cgImage: images[Int(i)])
      frameCount = Int(delays[Int(i)] / gcd)

      for _ in 0..<frameCount {
        frames.append(frame)
      }
    }

    let animation = UIImage.animatedImage(with: frames,
                                          duration: Double(duration) / 1000.0)

    return animation
  }
}

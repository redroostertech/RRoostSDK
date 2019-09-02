import UIKit

class RangeSliderTrackLayer: CALayer {
  weak var rangeSlider: RangeSlider?
  
  override func draw(in ctx: CGContext) {
    guard let slider = rangeSlider else {
      return
    }
    
    let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    ctx.addPath(path.cgPath)

    ctx.setFillColor(slider.trackTintColor.cgColor)
    ctx.fillPath()

    ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
    let currentValuePosition = slider.positionForValue(slider.currentValue)
    let rect = CGRect(x: 0, y: 0,
                      width: currentValuePosition,
                      height: bounds.height)
    ctx.fill(rect)
  }
}

import UIKit

open class RangeSlider: UIControl {
    override open var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }

    open var trackLayerBGColor: UIColor = .clear {
        didSet {
            configureSlider()
        }
    }
    open var minimumValue: CGFloat = 0 {
        didSet {
            updateLayerFrames()
        }
    }
    open var maximumValue: CGFloat = 1 {
        didSet {
            updateLayerFrames()
        }
    }
    open var currentValue: CGFloat = 0.2 {
        didSet {
            updateLayerFrames()
        }
    }
    open var trackTintColor =  UIColor.landingPageGray {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    open var trackHighlightTintColor = UIColor(hexString: "#5EC6C3", withAlpha: 1.0)! {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }

    private let trackLayer = RangeSliderTrackLayer()
    private let thumbView = UILabel()
    private let thumbSize = CGSize(width: 50, height: 25)

    private var previousLocation = CGPoint()
    
    open var didBeginTracking: ((RangeSlider) -> ())?
    open var didEndTracking: ((RangeSlider) -> ())?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureSlider()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSlider()
    }

    private func configureSlider() {
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)

        thumbView.backgroundColor = UIColor.landingPageBlueGreen
        thumbView.applyCornerRadius()
        thumbView.textColor = .white
        thumbView.textAlignment = .center
        addSubview(thumbView)

        updateLayerFrames()
    }

    private func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: 14.6)
        trackLayer.masksToBounds = true
        trackLayer.cornerRadius = trackLayer.frame.height / 2
        trackLayer.setNeedsDisplay()
        thumbView.frame = CGRect(origin: thumbOriginForValue(currentValue), size: thumbSize)
        thumbView.text = "\(Int(currentValue * 100))"
        CATransaction.commit()
    }

    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }

    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        let x = positionForValue(value) - thumbSize.width / 2.0
        return CGPoint(x: x, y: (bounds.height - thumbSize.height) / 2.0)
    }
}

extension RangeSlider {
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        if thumbView.frame.contains(previousLocation) {
            thumbView.isHighlighted = true
        }
        didBeginTracking?(self)
        return thumbView.isHighlighted
    }

    override open func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
        previousLocation = location
        if thumbView.isHighlighted {
            currentValue += deltaValue
            currentValue = boundValue(currentValue, toLowerValue: minimumValue, upperValue: maximumValue)
        }
        thumbView.text = "\(Int(currentValue * 100))"
        sendActions(for: .valueChanged)
        return true
    }

    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat,
                            upperValue: CGFloat) -> CGFloat {
        return min(max(value, lowerValue), upperValue)
    }

    override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        thumbView.isHighlighted = false
        didEndTracking?(self)
    }
}

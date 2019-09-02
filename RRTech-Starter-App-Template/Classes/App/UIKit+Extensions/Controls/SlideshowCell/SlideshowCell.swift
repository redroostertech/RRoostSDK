import UIKit

public class SlideshowCell: UITableViewCell {
    @IBOutlet private weak var mainImage: UIImageView!
    @IBOutlet private weak var slideShowBack: UIButton!
    @IBOutlet private weak var nextSlideShowButton: UIButton!
    
    var images = [
        "https://www.fillmurray.com/640/360",
        "https://loremflickr.com/640/360"]
    private var currentIndex: Int = 0
    private var maxIndex: Int {
        return images.count - 1
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        loadImage()
    }
    
    func resetSlideshow() {
        currentIndex = 0
        mainImage.imageFromUrl(theUrl: images[currentIndex])
    }
    
    func loadImage() {
        mainImage.imageFromUrl(theUrl: images[currentIndex])
    }

    @IBAction private func previousSlide(_ sender: Any) {
        if currentIndex > 0 {
            currentIndex -= 1
            loadImage()
        } else {
            resetSlideshow()
        }
    }
    @IBAction private func nextSlide(_ sender: Any) {
        if currentIndex >= maxIndex {
            resetSlideshow()
        } else {
            currentIndex += 1
            loadImage()
        }
    }
}

import UIKit

public class SlideshowCell: UITableViewCell {
    @IBOutlet private weak var mainImage: UIImageView!
    @IBOutlet private weak var slideShowBack: UIButton!
    @IBOutlet private weak var nextSlideShowButton: UIButton!
    
    private var images: [String]?
    private var currentIndex: Int = 0
    private var maxIndex: Int {
        guard let images = self.images else { return 0 }
        return images.count - 1
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        loadImage()
    }

    public func configure(imageUrls: [String]) {
      self.images = imageUrls
    }
    
    private func resetSlideshow() {
        currentIndex = 0
        if let images = self.images {
            mainImage.imageFromUrl(theUrl: images[currentIndex])
        }
    }
    
    private func loadImage() {
        if let images = self.images {
            mainImage.imageFromUrl(theUrl: images[currentIndex])
        }
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

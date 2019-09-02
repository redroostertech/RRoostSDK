import UIKit
import SDWebImage

class SlideshowCell: UITableViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var slideShowBack: UIButton!
    @IBOutlet weak var nextSlideShowButton: UIButton!
    
    var images = [
        "https://www.fillmurray.com/640/360",
        "https://loremflickr.com/640/360"]
    var currentIndex: Int = 0
    var maxIndex: Int {
        return images.count - 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadImage()
    }
    
    func resetSlideshow() {
        currentIndex = 0
        mainImage.sd_setImage(with: URL(string: images[currentIndex]), completed: nil)
    }
    
    func loadImage() {
        mainImage.sd_setImage(with: URL(string: images[currentIndex]), completed: nil)
    }

    @IBAction func previousSlide(_ sender: Any) {
        if currentIndex > 0 {
            currentIndex -= 1
            loadImage()
        } else {
            resetSlideshow()
        }
    }
    @IBAction func nextSlide(_ sender: Any) {
        if currentIndex >= maxIndex {
            resetSlideshow()
        } else {
            currentIndex += 1
            loadImage()
        }
    }
}

extension NewsSlideshowCell {
    static var identifier: String {
        return String(describing: self)
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

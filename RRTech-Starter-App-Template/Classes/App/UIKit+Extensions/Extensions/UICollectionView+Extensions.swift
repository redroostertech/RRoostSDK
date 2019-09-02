import Foundation
import UIKit

extension UICollectionView {
    func registerNib(withNibName nibName: String, forReuseIdentifier identifier: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
}

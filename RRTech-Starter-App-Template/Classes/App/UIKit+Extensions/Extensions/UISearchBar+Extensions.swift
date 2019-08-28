import UIKit

public extension UISearchBar {
  func setPlaceholderTextColorTo(color: UIColor) {
    let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
    textFieldInsideSearchBar?.textColor = color
    let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
    textFieldInsideSearchBarLabel?.textColor = color
  }

  func setMagnifyingGlassColorTo(color: UIColor) {
    let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
    let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
    glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
    glassIconView?.tintColor = color
  }
}

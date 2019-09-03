import Foundation
import UIKit

public protocol ImageSelectorManagerDelegate: class {
  func imageSelector(_ manager: ImageSelectorManager, returnImage image: UIImage, returnData data: Data, url: URL?)
}

public class ImageSelectorManager: NSObject {

    var imagePicker: UIImagePickerController!
    var parentController: Any?
    weak var delegate: ImageSelectorManagerDelegate?

    public override init() {
        super.init()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        if let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
            imagePicker.mediaTypes = mediaTypes
        }
    }

    public convenience init(delegate: ImageSelectorManagerDelegate?) {
      self.init()
      self.delegate = delegate
    }

    public func setDelegate(_ delegate: ImageSelectorManagerDelegate?) {
        self.delegate = delegate
    }

    public func showImagePicker() {
        if let parent = parentController as? UINavigationController {
            parent.pushToView(withViewController: imagePicker)
        }
        if let parent = parentController as? UIViewController {
            parent.present(imagePicker, animated: true, completion: nil)
        }
    }

    public func dismissImagePicker() {
        if let parent = parentController as? UINavigationController {
            parent.popViewController(animated: true)
        }
        if let parent = parentController as? UIViewController {
            parent.dismiss(animated: true, completion: nil)
        }
    }
}

extension ImageSelectorManager: UIImagePickerControllerDelegate {
  private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            dismissImagePicker()
            return
        }

        #if swift(>=4.2)
          guard let data = selectedImage.jpegData(compressionQuality: 0.75) else { return }
        #else
          guard let data = UIImageJPEGRepresentation(selectedImage, 0.75) else { return }
        #endif

        
        let imageName = UUID().uuidString
        let imagePath = Utilities.getDocumentsDirectory().appendingPathComponent(imageName)

        do {
            try data.write(to: imagePath, options: .atomicWrite)

            print("Image Path from ImageSelectorManager is \(imagePath)")

            self.delegate?.imageSelector(self, returnImage: selectedImage, returnData: data, url: imagePath)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissImagePicker()
    }
}

extension ImageSelectorManager: UINavigationControllerDelegate { }

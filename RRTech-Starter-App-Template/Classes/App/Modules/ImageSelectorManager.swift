import Foundation
import UIKit

protocol ImageSelectorManagerDelegate {
    func returnImageForUpload(_ image: UIImage, uploadData: Data, url: URL?)
}

class ImageSelectorManager: NSObject {
    var imagePicker: UIImagePickerController!
    var parentController: Any?
    var delegate: ImageSelectorManagerDelegate?
    override init() {
        super.init()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        if let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
            imagePicker.mediaTypes = mediaTypes
        }
    }
    func showImagePicker() {
        if let parent = parentController as? UINavigationController {
            parent.pushToView(withViewController: imagePicker)
        }
        if let parent = parentController as? UIViewController {
            parent.present(imagePicker, animated: true, completion: nil)
        }
    }
    func dismissImagePicker() {
        if let parent = parentController as? UINavigationController {
            parent.popViewController(animated: true)
        }
        if let parent = parentController as? UIViewController {
            parent.dismiss(animated: true, completion: nil)
        }
    }
}

extension ImageSelectorManager: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            dismissImagePicker()
            return
        }
        guard let data = selectedImage.jpegData(compressionQuality: 0.75) else {
            return
        }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        do {
            try data.write(to: imagePath, options: .atomicWrite)
            print(imagePath)
            self.delegate?.returnImageForUpload(selectedImage, uploadData: data, url: imagePath)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissImagePicker()
    }
}

extension ImageSelectorManager: UINavigationControllerDelegate {

}

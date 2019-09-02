import UIKit

class BaseNavigationVC: BaseVC {
    
    var showNavBarLogo: Bool = false
    var hideBackButtonText: Bool = false
    var hideNavBar: Bool = false
    var hideNavBarHairline: Bool = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addLogoToNavBar()
        hideBackButtonTextAction()
        hideNavBarAction()
        hideNavBarHairlineAction()
    }

    func goBackHome() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    func addLogoToNavBar() {
        if showNavBarLogo {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 32))
            imageView.contentMode = .scaleAspectFit
            let image = UIImage(named: "logo")
            imageView.image = image
            self.navigationItem.titleView = imageView
        }
    }
    
    func hideBackButtonTextAction() {
        if hideBackButtonText {
            self.clearNavigationBackButtonText()
        }
    }
    
    func hideNavBarAction() {
        if hideNavBar {
            self.hideNavigationBar()
        }
    }
    
    func hideNavBarHairlineAction() {
        if hideNavBarHairline {
            self.hideNavigationBarHairline()
        }
    }
}

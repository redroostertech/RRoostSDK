import UIKit

public class BaseNavigationVC: BaseVC {
    
    var showNavBarLogo: Bool = false
    var hideBackButtonText: Bool = false
    var hideNavBar: Bool = false
    var hideNavBarHairline: Bool = false

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addLogoToNavBar()
        hideBackButtonTextAction()
        hideNavBarAction()
        hideNavBarHairlineAction()
    }
    
    public func addLogoToNavBar() {
        if showNavBarLogo {
            
        }
    }
    
    public func hideBackButtonTextAction() {
        if hideBackButtonText {
            self.clearNavigationBackButtonText()
        }
    }
    
    public func hideNavBarAction() {
        if hideNavBar {
            self.hideNavigationBar()
        }
    }
    
    public func hideNavBarHairlineAction() {
        if hideNavBarHairline {
          #if canImport(ChameleonFramework)
            self.hideNavigationBarHairline()
          #else
          #endif
        }
    }
}

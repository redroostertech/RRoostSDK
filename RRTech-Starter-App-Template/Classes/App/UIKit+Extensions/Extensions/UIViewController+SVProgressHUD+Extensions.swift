//
//  UIViewController+SVProgressHUD+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//

import Foundation
// TODO: - Uncomment frameworks after 'pod install'
// import SVProgressHUD

// MARK: - Uncomment after 'pod install'
//  public extension UIViewController {
//    func showErrorAlert(message: String?) {
//        SVProgressHUD.showError(withStatus: message ?? "")
//        SVProgressHUD.setDefaultStyle(.dark)
//        SVProgressHUD.setDefaultMaskType(.gradient)
//        SVProgressHUD.setMinimumDismissTimeInterval(1)
//    }
//
//    func showErrorAlert(_ error: DadHiveError) {
//        SVProgressHUD.showError(withStatus: error.rawValue)
//        SVProgressHUD.setDefaultStyle(.dark)
//        SVProgressHUD.setDefaultMaskType(.gradient)
//        SVProgressHUD.setMinimumDismissTimeInterval(1)
//    }
//
//    func showAlertErrorIfNeeded(error: Error?) {
//        if let e = error {
//            showErrorAlert(message: e.localizedDescription)
//        } else {
//            SVProgressHUD.dismiss()
//        }
//    }
//
//    func showHUD() {
//        SVProgressHUD.show()
//        UIApplication.shared.beginIgnoringInteractionEvents()
//        SVProgressHUD.setBackgroundColor(AppColors.darkGreen)
//        SVProgressHUD.setForegroundColor(UIColor.white)
//    }
//
//    func hideHUD() {
//        if SVProgressHUD.isVisible() {
//            SVProgressHUD.dismiss()
//        }
//        UIApplication.shared.endIgnoringInteractionEvents()
//    }
//  }

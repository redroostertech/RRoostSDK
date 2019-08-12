//
//  Configuration.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation
import UIKit

// MARK: - App Settings
public let kAppName = ""
public let kAdMobEnabled = false // If 'TRUE' uncomment lines below
// public let kAdMobApplicationID = ""
// public let kAdMobInterstitialUnitID = ""
// public let kCloudServerKey = ""

// MARK: - UIKit Global Configurations
public let kTopOfScreen = UIScreen.main.bounds.minY
public let kBottomOfScreen = UIScreen.main.bounds.maxY
public let kFarLeftOfScreen = UIScreen.main.bounds.minX
public let kFarRightOfScreen = UIScreen.main.bounds.maxX
public let kWidthOfScreen = UIScreen.main.bounds.width
public let kHeightOfScreen = UIScreen.main.bounds.height

public let kBorderThickness: CGFloat = 2.0
public let kRoundedCorners: CGFloat = 0.15

// MARK: - Textfield Global Configurations
public let kTextFieldHeight: CGFloat = 42
public let kTextFieldPadding: CGFloat = 10.0

// MARK: - Animation Global Configurations
public let kAnimationDuration: Double = 2.0

// MARK: - UICollectionView+UITableView Global Configurations
public let kPrimaryNoSpacing: CGFloat = 0.0
public let kPrimarySpacing: CGFloat = 8.0
public let kPrimaryHalfSpacing: CGFloat = kPrimarySpacing / 2
public let kInsets: CGFloat = 8.0

public let kTablePrimaryCellHeight: CGFloat = 200.0
public let kTableSecondaryCellHeight: CGFloat = 200.0

public let kTableHeaderHeight: CGFloat = 50.0
public let kTableFooterHeight: CGFloat = 50.0

public let kCollectionPrimaryCellHeight: CGFloat = 200.0
public let kCollectionPrimaryCellWidth: CGFloat = 200.0
public let kCollectionSecondaryCellHeight: CGFloat = 200.0
public let kCollectionSecondaryCellWidth: CGFloat = 200.0

public let kCollectionHeaderHeight: CGFloat = 50.0
public let kCollectionFooterHeight: CGFloat = 50.0

// MARK: - Navigation Bar Global Configuration
public let kBarBtnSize = CGSize(width: 32.0, height: 32.0)
public let kBarBtnPoint = CGPoint(x: 0.0, y: 0.0)

// MARK: - Image+ImageView Global Configurations
public let kJPEGImageQuality : CGFloat = 0.4
public let kPagination : UInt = 10
public let kMaxConcurrentImageDownloads = 2

public let kIconSizeWidth : CGFloat = 32
public let kIconSizeHeight : CGFloat = 32

public let kPhotoShadowRadius : CGFloat = 10.0
public let kPhotoShadowColor : UIColor = UIColor(white: 0, alpha: 0.1)

public let kProfilePhotoSize : CGFloat = 100

//  MARK: - Custom Typography Global Configurations
// Provide names and styles of custom font(s)
public let kFontTitle = ""
public let kFontSubHeader = ""
public let kFontMenu = ""
public let kFontBody = ""
public let kFontCaption = ""
public let kFontButton = ""
public var kFontSizeTitle: CGFloat { return 28 }
public var kFontSizeSubHeader: CGFloat { return 24 }
public var kFontSizeMenu: CGFloat { return 18 }
public var kFontSizeBody: CGFloat { return 18 }
public var kFontSizeCaption: CGFloat { return 12 }
public var kFontSizeButton: CGFloat { return 16 }

// MARK: - API Global Configurations
public var debugMode = true
public let kBaseTestURL = ""
public let kTestURL = kBaseTestURL + "api/v1/"
public let kBaseLiveURL = ""
public let kLiveURL = kBaseLiveURL + "api/v1/"

// TODO: - Uncomment lines below if pointing to LocalHost
// public let kBaseLocalURL = "http://localhost:3000/"
//public let kLocalURL = kBaseLocalURL + "api/v1/"

// MARK: - ViewController Identifiers
public let kViewController = "ViewController"

// MARK: - Storyboard Identifiers
public let kMainStoryboard = "Main"

// MARK: - Observer Strings
public let kLocationAccessCheckObservationKey = "observeLocationAccessCheck"
public let kSaveLocationObservationKey = "saveLocationObservationKey"
public let kNotificationAccessCheckObservationKey = "observeNotificationAccessCheck"

//  MARK: - Other Strings
public let kLocationEnabled = "Location services enabled"
public let kLocationDisabled = "Location services not enabled"
public let kNotificationEnabled = "Notification services enabled"
public let kNotificationDisabled = "Notification services not enabled"
public let kLoginText = "Sign In"
public let kSignUpText = "Sign Up"

// MARK: - App Defaults Strings

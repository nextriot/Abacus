//
//  Constants.swift
//  Abacus
//
//  Created by Kyle Gillen on 01/09/2015.
//  Copyright © 2015 Next Riot. All rights reserved.
//

import UIKit

struct Constants {
  
  struct Colors {
    // Primary
    static let Fuchsia      = UIColor(red: 255 / 255, green: 37 / 255, blue: 104 / 255, alpha: 1.0)
    static let Gorse        = UIColor(red: 254 / 255, green: 249 / 255, blue: 85 / 255, alpha: 1.0)
    static let Aquamarine   = UIColor(red: 67 / 255, green: 255 / 255, blue: 182 / 255, alpha: 1.0)
    // Accent
    static let LightGrey    = UIColor(white: 0.95, alpha: 1.0)
    static let MediumGrey   = UIColor(white: 0.82, alpha: 1.0)
    static let DarkGrey     = UIColor(white: 0.45, alpha: 1.0)
  }

}

enum UIUserInterfaceIdiom : Int {
  case Unspecified
  case Phone
  case Pad
}

struct ScreenSize {
  static let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
  static let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
  static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
  static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
  static let IS_IPHONE_4_OR_LESS =  UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
  static let IS_IPHONE_5 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
  static let IS_IPHONE_6 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
  static let IS_IPHONE_6P = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
}
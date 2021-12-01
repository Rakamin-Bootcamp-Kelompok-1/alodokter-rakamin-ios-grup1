//
//  DeviceHelper.swift
//  Alodokter_bootcamp
//
//  Created by Abdul Aziz on 20/11/21.
//

import Foundation
import UIKit

enum DeviceModel {
    case iPhone4, iPhone5, iPhone6, iPhone6splus, iPhone7AndiPhone8, iPhoneX, iPad2, iPad3, iPad4, iPadAir, iPadAir2, iPAdMini, iPadMini2, iPadMini3, iPadMini4, iPadPro, iphonePlusType, iphoneNonplus, iphone5All, iPhoneXandNonPlus, iPhoneXRorXSMax, iPhoneXSMaxORiPhoneXRORiPhone11ORiPhone11Pro
}

class DeviceHelper {
    
    class func getDeviceModelByScreenHeight() -> DeviceModel {
        let height = UIScreen.main.bounds.height
        
        switch height {
        case 480:
            return .iPhone4
        case 568:
            return .iPhone5
        case 667:
            return .iPhone6
        case 812:
            return .iPhoneX
        case 667:
            return .iPhone7AndiPhone8
        case 896:
            return .iPhoneXRorXSMax
        default:
            // 736
            // default is for iphone 8 plus, iphone 6s plus, iphone 7plus
            return .iphonePlusType
        }
    }
    
    
    class func getDeviceModel() -> String {
        let device = getDeviceModelByScreenHeight()
        
        switch device {
        case .iPhone4:
            return "iPhone 4"
        case .iPhone5:
            return "iPhone 5 / 5s"
        case .iPhone6:
            return "iPhone 6"
        case .iPhoneX:
            return "iPhone X / XS"
        case .iPhone7AndiPhone8:
            return "iPhone 7 / iPhone 8"
        case .iPhoneXRorXSMax:
            return "iPhone XR / iPhone XS Max / iPhone 11 / iphone 11 max"
        default:
            // 736
            // default is for iphone 8 plus, iphone 6s plus, iphone 7plus
            return "iPhone 6s Plus / iPhone 7 Plus / iPhone 8 Plus"
        }
    }
    
    class func getDeviceModelByScreenWidth() -> DeviceModel {
        let width = UIScreen.main.bounds.width
        switch width {
        case 414:
            return .iphonePlusType
        case 320:
            return .iphone5All
        default:
            return .iPhoneXandNonPlus
        }
    }
    
    class func getDeviceWidthByScreenHeight() -> CGFloat {
        let model = getDeviceModelByScreenHeight()
        switch model {
        case .iPhoneX:
            return 375
        case .iphonePlusType:
            return 414
        case .iPhone6:
            return 374
        default:
            return 320
        }
    }
    
    class func getScreenSize() -> (width:CGFloat,height:CGFloat) {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        return (width:width,height:height)
    }
    
    class func isDeviceHasNotch() -> Bool {

        return UIDevice.current.hasNotch
    }
}

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

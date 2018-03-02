//
//  HomeViewController.swift
//  presentbase1
//
//  Created by Mac on 5/14/17.
//  Copyright © 2017 Lenah Syed. All rights reserved.
//

import UIKit
import UserNotifications

public extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}

class HomeViewController: UIViewController {

    var textViewSize: CGSize!
    var fixedWidth: CGFloat!
    var expectSize: CGSize!
    var expectFont: CGFont?

    @IBOutlet weak var homeTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewSize = homeTextView.frame.size
        fixedWidth = textViewSize.width
        let theSize = CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))
        expectSize = homeTextView.sizeThatFits(theSize)
        let uiExpectFont = homeTextView.font
        let fontName = uiExpectFont!.fontName as NSString
        let cgFont = CGFont(fontName)
    
        expectFont = cgFont
        
        // request permission for notifications
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert,.sound,.badge],
                completionHandler: { (granted,error) in
            }
            )
        } else {
            let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        }
        
        homeTextView.sizeToFit()
        homeTextView.layoutIfNeeded()
        let height = homeTextView.sizeThatFits(theSize).height
        homeTextView.contentSize.height = height
        checkForDevice()
        updateTextFont()

    }
    
    func updateTextFont() {
        if (homeTextView.text.isEmpty || __CGSizeEqualToSize(homeTextView.bounds.size, CGSize.zero)) {
            return;
        }
    }
    
    func checkForDevice() {
        let modelName = UIDevice.current.modelName

         if (modelName.lowercased().range(of: "iPhone 5S") != nil) {
            let theSize = CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))
            while (homeTextView.sizeThatFits(theSize).height > textViewSize.height) {
              //  expectFont = homeTextView.font!.withSize(homeTextView.font!.pointSize - 100)
                homeTextView.font = homeTextView.font!.withSize(homeTextView.font!.pointSize - 100)
            }
        }
        
        
        
        if (modelName.lowercased().range(of: "iphone 4s") != nil) {
            let theSize = CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))
            while (homeTextView.sizeThatFits(theSize).height > textViewSize.height) {
                expectFont = homeTextView.font!.withSize(homeTextView.font!.pointSize - 7) as! CGFont
                homeTextView.font = homeTextView.font!.withSize(homeTextView.font!.pointSize - 7)
            }
        }
        
        if (modelName.lowercased().range(of: "iphone 6") != nil) {
            let theSize = CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))
            while (homeTextView.sizeThatFits(theSize).height > textViewSize.height) {
                expectFont = homeTextView.font!.withSize(homeTextView.font!.pointSize + 0) as! CGFont
                homeTextView.font = homeTextView.font!.withSize(homeTextView.font!.pointSize + 0)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

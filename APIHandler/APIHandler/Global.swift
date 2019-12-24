//
//  Global.swift
//  APIHandler
//
//  Created by Kumar Lav on 12/23/19.
//  Copyright © 2019 Kumar Lav. All rights reserved.
//

import Foundation
import SystemConfiguration
import MBProgressHUD


class Global: NSObject {

class var sharedInstance: Global {
    struct Static {
        static let instance: Global = Global()
    }
    return Static.instance
}

    
    //MARK: - Internet Connection Checking Methods
       
       class func isInternetAvailable() -> Bool {
           
           var zeroAddress = sockaddr_in()
           zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
           zeroAddress.sin_family = sa_family_t(AF_INET)
           
           guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
               $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                   SCNetworkReachabilityCreateWithAddress(nil, $0)
               }
           }) else {
               return false
           }
           
           var flags: SCNetworkReachabilityFlags = []
           if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
               return false
           }
           
           let isReachable = flags.contains(.reachable)
           let needsConnection = flags.contains(.connectionRequired)
           
           return (isReachable && !needsConnection)
       }
    
    
    //MARK: - Global alert Methods
       
       static func showAlertMessageWithOkButtonAndTitle(_ strTitle: String, andMessage strMessage: String)
       {
           if objc_getClass("UIAlertController") == nil
           {
            print("if objc_getClass:::::::::::")
               let alert: UIAlertView = UIAlertView(title: strTitle, message: strMessage, delegate: nil, cancelButtonTitle: "OK", otherButtonTitles: "")
               alert.show()
               
           }
           else
           {
             
            let alertController: UIAlertController = UIAlertController(title:strTitle, message: strMessage, preferredStyle: UIAlertController.Style.alert)
               print(" else objc_getClass:::::::::::",strTitle,strMessage)
               let ok: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               alertController.addAction(ok)
               
               let topWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
               topWindow.rootViewController = UIViewController()
               topWindow.windowLevel = UIWindow.Level.alert
               topWindow.makeKeyAndVisible()
               topWindow.rootViewController!.present(alertController, animated: true, completion: {
                   
               })
           }
       }
    
    //MARK: - Temprory Global alert Methods
    static func Temp_Alert(msg: String)
    {
        let alert = UIAlertController(title: "", message: msg,preferredStyle: UIAlertController.Style.alert)
        //self.present(alert, animated: true, completion: nil)
        
        let topWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        topWindow.rootViewController = UIViewController()
        topWindow.windowLevel = UIWindow.Level.alert + 1
        topWindow.makeKeyAndVisible()
        topWindow.rootViewController!.present(alert, animated: true, completion: {
            
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(1.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
            alert.dismiss(animated: true, completion: {() -> Void in
            })
        })
    }
    
    
    //MARK: Show Progresshud on the middle when API calls
    class func showGlobalProgressHUD(withTitle title: String) -> MBProgressHUD {
           let window: UIWindow? = UIApplication.shared.windows.last
           MBProgressHUD.hide(for: window!, animated: true)
           let hud = MBProgressHUD.showAdded(to: window!, animated: true)
           hud.mode = .indeterminate
           hud.backgroundView.color = UIColor(white: 0, alpha: 0.3)
           hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
           hud.label.text = title
           return hud
       }
    
    
    // Dissmiss Progresshud
    class func dismissGlobalHUD() {
        let window: UIWindow? = UIApplication.shared.windows.last
        MBProgressHUD.hide(for: window!, animated: true)
    }
    
    
   // if you need to find First Letter of String use this Method
    class func firstLetter(_ str:String) -> String? {
           guard let firstChar = str.first else {
               return nil
           }
           return String(firstChar)
       }
    
    
    // MARK: - Creates a UIColor from a Hex string.
    
    static func hexStringToUIColor (_ hex:String) -> UIColor
    {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
     //MARK: - Get Url from String type parameter
    static func getURLFromString(_ str: String) -> String {
        let urlStr: String = str.replacingOccurrences(of: " ", with: "%20")
        return urlStr
    }
    
    //MARK: - Image Scalling Methods
    
    static func imageWithImage(_ image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// Trim for String
       static func Trim(_ value: String) -> String {
           let value = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
           return value
       }
    
    
    // checks whether string value exists or it contains null or null in string
      static func stringExists(_ str: String) -> Bool {
          var strString : String? = str
          
          if strString == nil {
              return false
          }
          
          if strString == String(describing: NSNull()) {
              return false
          }
          if (strString == "<null>") {
              return false
          }
          if (strString == "(null)") {
              return false
          }
          strString = Global.Trim(str)
          if (str == "") {
              return false
          }
          if strString?.count == 0 {
              return false
          }
          return true
      }
      
      // returns string value after removing null and unwanted characters
      
      static func getStringValue(_ str: AnyObject) -> String {
          if str is NSNull {
              return ""
          }
          else{
            
              var strString : String? = str as? String
              if Global.stringExists(strString!) {
                  strString = strString!.replacingOccurrences(of: "\t", with: " ")
                  strString = Global.Trim(strString!)
                  if (strString == "{}") {
                      strString = ""
                  }
                  if (strString == "()") {
                      strString = ""
                  }
                  if (strString == "null") {
                      strString = ""
                  }
                  return strString!
              }
              return ""
          }
      }
    
    static func getDateFromString(stndFormat: String,getFormat: String,dateString: String) -> String
       {
        
        // stndFormat is that Format which comes by String.
        // getFormat is that Format which Format you want.
        
           let dateFormatter = DateFormatter()
           var date_time_string = ""
           
               dateFormatter.dateFormat = stndFormat
               let date = dateFormatter.date(from: dateString)
               dateFormatter.dateFormat = getFormat
               if date != nil
               {
                   date_time_string = dateFormatter.string(from: date!)
               }
               else
               {
                   date_time_string = ""
               }
           
           return date_time_string
       }
    
    
    class func reloadTableViewDataAnimated(_ tableView: UITableView){
        UIView.transition(with: tableView, duration: 0.55, options: .transitionCrossDissolve, animations:
                      { () -> Void in
                      tableView.reloadData()
                      }, completion: nil);
        
        tableView.reloadData()
       }
    
    
    class func makeBlurImage(_ targetView:UIView?)
       {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
           let blurEffectView = UIVisualEffectView(effect: blurEffect)
           blurEffectView.frame = targetView!.bounds
           
           blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           targetView?.addSubview(blurEffectView)
       }
    
    
    class func containsOnlyLetters(_ candidate: String) -> Bool {
         let ValidationExpression = "^[A-Za-z]+$"
         return NSPredicate(format: "SELF MATCHES %@", ValidationExpression).evaluate(with: candidate)

     }
    
    
    
   class func uniqueId() -> String {
        return  UUID().uuidString
    }
    
    
    
}  // End of Global

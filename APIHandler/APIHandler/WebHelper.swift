
//  WebHelper.swift
//  APIHandler
//  Created by Kumar Lav on 12/23/19.
//  Copyright © 2019 Kumar Lav. All rights reserved.


import Foundation
import Alamofire
import MBProgressHUD


class WebHelper: NSObject {

//***//***//
/*
 ALAMOFIRE Post method
 strURl             = Pass the request URl of the method Api
 dictPost           = Pass the dicticnary of the parameter else pass nil
 viewController     = Pass the view of the view controller
 APIKey             = Pass the API key or header key of the server
 Response           = Response is of dictionary class
 */

  class func requestPostUrlWithoutprogressHud(strURL:String,Dictionary dictPost:[String: Any],Success success:@escaping (_ responce: NSDictionary) ->Void,Failure failure:@escaping (_ error: NSError) ->Void   )
    {
        
        if Global.isInternetAvailable()
        {
            Alamofire.request(ApiNames.DEFAULT_URL + strURL, method: .post, parameters: dictPost, headers: ["Apikey" : ApiNames.API_KEY])
                .responseJSON
                {
                    response in
                    switch response.result
                    {
                            case .success:
                                print(response.result.value!)
                                if response.result.value is NSDictionary
                                {
                                    success((response.result.value as? NSDictionary)!)
                                }
                            case .failure(let error):
                                
                                let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                                print(responseString)
                                
                                failure(error as NSError)
                    } // End of switch statment
            }// End of JSON
        }
        else
        {
            Global.showAlertMessageWithOkButtonAndTitle(ApiNames.APP_NAME, andMessage: ApiNames.NO_INTERNET_MESSAGE)
        }
        
    }
    
    
    
    
    class func requestPostUrl(strURL:String,Dictionary dictPost:[String: Any],Success success:@escaping (_ responce: NSDictionary) ->Void,Failure failure:@escaping (_ error: NSError) ->Void   )
    {
        
        if Global.isInternetAvailable()
        {
            let hud: MBProgressHUD = Global.showGlobalProgressHUD(withTitle: ApiNames.API_LOADING_MESSAGE)
            
            Alamofire.request(ApiNames.DEFAULT_URL + strURL, method: .post, parameters: dictPost, headers: ["Apikey" : ApiNames.API_KEY])
                .responseJSON
                {
                    response in
                    
                    Global.dismissGlobalHUD()
                    switch response.result
                    {
                        case .success:
                            print(response.result.value!)
                            if response.result.value is NSDictionary
                            {
                                success((response.result.value as? NSDictionary)!)
                            }
                        case .failure(let error):
                           
                            let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                            print(responseString)

                            failure(error as NSError)
                    }// End of Switch
                    hud.hide(animated: true)
            }  // End of JSON
        }
        else
        {
            Global.showAlertMessageWithOkButtonAndTitle(ApiNames.APP_NAME, andMessage: ApiNames.NO_INTERNET_MESSAGE)
        }
    }
    
    
    
    class func requestgetUrl(strURL:String,Dictionary dictPost:[String: Any],Controller viewController:UIViewController,Success success:@escaping (_ responce: NSDictionary) ->Void,Failure failure:@escaping (_ error: NSError) ->Void   )
    {
        
        if Global.isInternetAvailable()
        {
            MBProgressHUD.hide(for: viewController.view, animated: true)
            let loadingNotification = MBProgressHUD.showAdded(to: viewController.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.label.text = ApiNames.API_LOADING_MESSAGE
            
            Alamofire.request(ApiNames.DEFAULT_URL + strURL, method: .get, parameters: dictPost, headers: ["Apikey" : ApiNames.API_KEY])
                .responseJSON
                {
                    response in
                    
                    switch response.result
                    {
                    case .success:
                        print(response.result.value!)
                        if response.result.value is NSDictionary
                        {
                            success((response.result.value as? NSDictionary)!)
                        }
                    case .failure(let error):
                        
                        let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                        print(responseString)
                        
                        failure(error as NSError)
                    }
                    loadingNotification.hide(animated: true)
            }
        }
        else
        {
            
            Global.showAlertMessageWithOkButtonAndTitle(ApiNames.APP_NAME, andMessage: ApiNames.NO_INTERNET_MESSAGE)
        }
    }
    
    
    //***//***//
       /*
        ALAMOFIRE Post method with single image paramter
        strURl             = Pass the request URl of the method Api
        dictPost           = Pass the dicticnary of the parameter else pass nil
        viewController     = Pass the view of the view controller
        APIKey             = Pass the API key or header key of the server
        Response           = Response is of dictionary class
        outletImage        = Pass the uiimage
        imageName          = Pass the name of parameter which is to be send to server
        */
       
       class func requestPostUrlWithImage(strURL:String, Dictionary dictPost:[String: AnyObject], AndImage outletImage:UIImage, forImageParameterName imageName:String, Success success:@escaping (_ responce: NSDictionary) ->Void, Failure failure:@escaping (_ error: NSError) ->Void   )
       {
           if Global.isInternetAvailable()
           {
               let hud: MBProgressHUD = Global.showGlobalProgressHUD(withTitle: ApiNames.API_LOADING_MESSAGE)

               // Begin upload
               let URL = try! URLRequest(url: ApiNames.DEFAULT_URL + strURL , method: .post, headers: ["Apikey" : ApiNames.API_KEY])

               Alamofire.upload(multipartFormData: { multipartFormData in
                 
                   // import image to request
                if let imageData = outletImage.jpegData(compressionQuality: 1.0)
                   {
                        multipartFormData.append(imageData, withName: imageName, fileName: "\(Global.uniqueId()).png", mimeType: "image/png")
                   }
                   // import parameters
                   for (key, value) in dictPost {
                       let stringValue = value as! String
                       multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                   }
               }, with: URL, encodingCompletion: { encodingResult in
                   switch encodingResult {
                   case .success(let upload, _, _):
                       upload.responseJSON
                           {
                               response in
                             
                               switch response.result
                               {
                               case .success:
                                   print(response.result.value!)   // result of response serialization
                                   if response.result.value is NSDictionary
                                   {
                                       success((response.result.value as? NSDictionary)!)
                                   }
                                  
                               case .failure(let error):
                                   let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                                   print(responseString)
                                   
                                   failure(error as NSError)
                               }
                               hud.hide(animated: true)
                       }
                   case .failure(let encodingError):
                       print(encodingError)
                       hud.hide(animated: true)
                   }
               })
           }
           else
           {
               Global.showAlertMessageWithOkButtonAndTitle(ApiNames.APP_NAME, andMessage: ApiNames.NO_INTERNET_MESSAGE)
           }
       }
       
       //***//***//
       /*
        ALAMOFIRE Post method with multiple image paramter
        strURl             = Pass the request URl of the method Api
        dictPost           = Pass the dicticnary of the parameter else pass nil
        viewController     = Pass the view of the view controller
        APIKey             = Pass the API key or header key of the server
        Response           = Response is of dictionary class
        outletImageArray   = Pass the array of uiimage
        imageName          = Pass the name of parameter which is to be send to server
        */
       
       class func requestPostUrlWithMultipleImage(strURL:String, Dictionary dictPost:[String: AnyObject], AndImage outletImageArray:NSArray, forImageParameterName imageName:NSString, Success success:@escaping (_ responce: NSDictionary) ->Void, Failure failure:@escaping (_ error: NSError) ->Void   )
       {
           if Global.isInternetAvailable()
           {
               let hud: MBProgressHUD = Global.showGlobalProgressHUD(withTitle: ApiNames.API_LOADING_MESSAGE)

               // Begin upload
               let URL = try! URLRequest(url: ApiNames.DEFAULT_URL + strURL , method: .post, headers: ["Apikey" : ApiNames.API_KEY])
               
               Alamofire.upload(multipartFormData: { multipartFormData in
                   
                   for image in outletImageArray
                   {
                       // import image to request
                    let img = image as! UIImage
                    if let imageData = img.jpegData(compressionQuality: 1.0) {
                           multipartFormData.append(imageData, withName: imageName as String, fileName: "myImage\(Global.uniqueId()).png", mimeType: "image/png")
                       }
                      
                   }
                   
                   // import parameters
                   for (key, value) in dictPost
                   {
                       if value is String
                       {
                           let stringValue = value as! String
                           multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                       }
                   }
                   
               }, with: URL, encodingCompletion: { encodingResult in
                   switch encodingResult {
                   case .success(let upload, _, _):
                       upload.responseJSON
                           {
                               response in
                              
                               switch response.result
                               {
                               case .success:
                                   print(response.result.value!)   // result of response serialization
                                   if response.result.value is NSDictionary
                                   {
                                       success((response.result.value as? NSDictionary)!)
                                   }
                                   
                               case .failure(let error):
                                   let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                                   print(responseString)
                                   
                                   failure(error as NSError)
                               }
                               hud.hide(animated: true)
                               
                       }
                   case .failure(let encodingError):
                       print(encodingError)
                       hud.hide(animated: true)
                   }
               })
           }
           else
           {
               Global.showAlertMessageWithOkButtonAndTitle(ApiNames.APP_NAME, andMessage: ApiNames.NO_INTERNET_MESSAGE)
           }
       }
       
       //***//***//
       /*
        ALAMOFIRE Post method with single image paramter
        strURl             = Pass the request URl of the method Api
        dictPost           = Pass the dicticnary of the parameter else pass nil
        viewController     = Pass the view of the view controller
        APIKey             = Pass the API key or header key of the server
        Response           = Response is of dictionary class
        filePath           = Pass the name of parameter which is to be send to server
        fileName           = Pass the file name
        */
       
       class func requestPostUrlWithFile(strURL:String, Dictionary dictPost:[String: AnyObject], AndFilePath filePath:URL, forFileParameterName fileName:String, Success success:@escaping (_ responce: NSDictionary) ->Void, Failure failure:@escaping (_ error: NSError) ->Void   )
       {
           if Global.isInternetAvailable()
           {
               let hud: MBProgressHUD = Global.showGlobalProgressHUD(withTitle: ApiNames.API_LOADING_MESSAGE)

               // Begin upload
               let URL = try! URLRequest(url: ApiNames.DEFAULT_URL + strURL , method: .post, headers: ["Apikey" : ApiNames.API_KEY])

               Alamofire.upload(multipartFormData: { multipartFormData in
                   
                   multipartFormData.append(filePath, withName: fileName)

                   // import parameters
                   for (key, value) in dictPost {
                       let stringValue = value as! String
                       multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                   }
               }, with: URL, encodingCompletion: { encodingResult in
                   switch encodingResult {
                   case .success(let upload, _, _):
                       upload.responseJSON
                           {
                               response in

                               switch response.result
                               {
                               case .success:
                                   print(response.result.value!)   // result of response serialization
                                   if response.result.value is NSDictionary
                                   {
                                       success((response.result.value as? NSDictionary)!)
                                   }
                                   
                               case .failure(let error):
                                   let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                                   print(responseString)
                                   
                                   failure(error as NSError)
                               }
                               hud.hide(animated: true)
                        
                       }
                   case .failure(let encodingError):
                       print(encodingError)
                       hud.hide(animated: true)
                   }
               })
           }
           else
           {
               Global.showAlertMessageWithOkButtonAndTitle(ApiNames.APP_NAME, andMessage: ApiNames.NO_INTERNET_MESSAGE)
           }
       }

       //***//***//
       /*
        ALAMOFIRE Post method with single image paramter
        strURl             = Pass the request URl of the method Api
        dictPost           = Pass the dicticnary of the parameter else pass nil
        viewController     = Pass the view of the view controller
        APIKey             = Pass the API key or header key of the server
        Response           = Response is of dictionary class
        outletImage        = Pass the uiimage
        imageName          = Pass the name of parameter which is to be send to server
        filePath           = Pass the name of parameter which is to be send to server
        fileName           = Pass the file name

        */
       
       class func requestPostUrlWithImageAndFile(strURL:String, Dictionary dictPost:[String: AnyObject], AndImage outletImage:UIImage, forImageParameterName imageName:String, AndFilePath filePath:URL, forFileParameterName fileName:String, Success success:@escaping (_ responce: NSDictionary) ->Void, Failure failure:@escaping (_ error: NSError) ->Void   )
       {
           if Global.isInternetAvailable()
           {
               let hud: MBProgressHUD = Global.showGlobalProgressHUD(withTitle: ApiNames.API_LOADING_MESSAGE)

               // Begin upload
               let URL = try! URLRequest(url: ApiNames.DEFAULT_URL + strURL , method: .post, headers: ["Apikey" : ApiNames.API_KEY])
               
               Alamofire.upload(multipartFormData: { multipartFormData in
                   
                   multipartFormData.append(filePath, withName: fileName)
                   
                   // import image to request
                if let imageData = outletImage.jpegData(compressionQuality: 1.0)
                   {
                   
                    multipartFormData.append(imageData, withName: imageName, fileName: "\(Global.uniqueId()).png", mimeType: "image/png")
                   }
                   
                   // import parameters
                   for (key, value) in dictPost {
                       let stringValue = value as! String
                       multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                   }
               }, with: URL, encodingCompletion: { encodingResult in
                   switch encodingResult {
                   case .success(let upload, _, _):
                       upload.responseJSON
                           {
                               response in
                               
                               switch response.result
                               {
                               case .success:
                                   print(response.result.value!)   // result of response serialization
                                   if response.result.value is NSDictionary
                                   {
                                       success((response.result.value as? NSDictionary)!)
                                   }
                                   
                               case .failure(let error):
                                   let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                                   print(responseString)
                                   
                                   failure(error as NSError)
                               }
                               hud.hide(animated: true)
                       }
                   case .failure(let encodingError):
                       print(encodingError)
                       hud.hide(animated: true)
                   }
               })
           }
           else
           {
               Global.showAlertMessageWithOkButtonAndTitle(ApiNames.APP_NAME, andMessage: ApiNames.NO_INTERNET_MESSAGE)
           }
       }
    
}  // End of WebHelper

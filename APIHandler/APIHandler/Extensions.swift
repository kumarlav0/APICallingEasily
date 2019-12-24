//
//  Extensions.swift
//  APIHandler
//
//  Created by Kumar Lav on 12/23/19.
//  Copyright © 2019 Kumar Lav. All rights reserved.
//

import UIKit


extension UIViewController
{
    
    func alertWithOk(title:String,body:String)
       {
           let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
           
           let ok = UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction) in
               alert.dismiss(animated: true, completion: nil)
           })
        
            alert.addAction(ok)
           self.present(alert, animated: true, completion: nil)
       }
    
    
    func alertWithAction(buttonTitle:String,title:String,body:String,response: @escaping(_ isOk:Bool)-> Void )
       {
           let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
           
           let ok = UIAlertAction(title: buttonTitle, style: .default, handler: {(action:UIAlertAction) in
               response(true)
               alert.dismiss(animated: true, completion: nil)
           })
           
          let no = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           
            alert.addAction(ok)
            alert.addAction(no)
           self.present(alert, animated: true, completion: nil)
       }
    
    
    func alertActionOk(title:String,body:String,response: @escaping(_ isOk:Bool)-> Void )
          {
              let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
              
              let ok = UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction) in
                  response(true)
                  alert.dismiss(animated: true, completion: nil)
              })
           
               alert.addAction(ok)
              self.present(alert, animated: true, completion: nil)
          }
    
    
}

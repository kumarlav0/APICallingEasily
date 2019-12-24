//
//  ExampleVC.swift
//  APIHandler
//
//  Created by Kumar Lav on 12/23/19.
//  Copyright © 2019 Kumar Lav. All rights reserved.
//

import UIKit
// if you need to Call any API than you nedd to add some code on InFo.plist file.
// you need to set App Transport Security Setting. and Allow Arbitrary Load = true

// XML code
/*
 <key>NSAppTransportSecurity</key>
 <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
 </dict>
 **/


class ExampleVC: UIViewController
{
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    var dataArr = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func refreshNewData(_ sender: Any) {
     
                
    }
    

}


extension ExampleVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = "Title"
        cell.detailTextLabel?.text = "Deatils of given title."
        return cell
    }
    
    
    
}



// MARK:- API Calling
extension ExampleVC{
   
    //MARK:- it is simple API call with Post Method
    func login()
    {
           var dictPost:[String: AnyObject]!
               dictPost = ["user_id":"user@gmail.com" as AnyObject,"password":"#@123abc" as AnyObject]
              
               WebHelper.requestPostUrl(strURL: ApiNames.LOGIN, Dictionary: dictPost, Success:{
                   success in
                
                 self.alertWithOk(title: "User Logged-In Successfully.....", body: "")
                
                }, Failure: {
                    failure in
                     self.alertWithOk(title: "", body: failure.localizedDescription)
                })
    }
    
    
    
    //MARK:- it is simple API call with Image Post Method
    func registrationWithImage()
    {
        let profileImg = UIImage(named: "img")
        var dictPost:[String: AnyObject]!
            dictPost = ["user_id":"user@gmail.com" as AnyObject,"password":"#@123abc" as AnyObject]
        
        WebHelper.requestPostUrlWithImage(strURL: ApiNames.REGISTER, Dictionary: dictPost, AndImage: profileImg!, forImageParameterName: "profile_img", Success: { (success) in
            
             self.alertWithOk(title: "User Registered Successfully.....", body: "")
         }, Failure: {
            failure in
            self.alertWithOk(title: "", body: failure.localizedDescription)
                })
    }
    
     //MARK:- it is simple API call with Multiple Image Post Method
    func sendMultipleImagesWithData()
    {
        let imgArr = [UIImage]()
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":"user@gmail.com" as AnyObject,"password":"#@123abc" as AnyObject]
        
        WebHelper.requestPostUrlWithMultipleImage(strURL: ApiNames.REGISTER, Dictionary: dictPost, AndImage: imgArr as NSArray, forImageParameterName: "img_arr", Success: { (success) in
            
        }, Failure: {
            failure in
            self.alertWithOk(title: "", body: failure.localizedDescription)
                })
        
    }
    
    
    
    
}

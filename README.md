# APICallingEasily
any one can call API very easily using my WebHelper file.

<h3> How to use. </h3>

<h4> Step 1. Just Download the project </br> 
     Step 2. UnZip file.</br> 
     Step 3. Copy APIHandler file to your project.</br> 
     Step 4. Install podfile which is given in podfile.</br> 
      # pod 'Alamofire'</br> 
      # pod 'MBProgressHUD'</br> 
      Step5. Use methods as given below.
</h4>


```swift
// Podfiles: pod 'Alamofire'
//           pod 'MBProgressHUD'
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
    


```

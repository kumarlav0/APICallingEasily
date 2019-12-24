# APICallingEasily
any one can call API very easily using my WebHelper file.

```swift
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

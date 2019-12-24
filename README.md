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

```

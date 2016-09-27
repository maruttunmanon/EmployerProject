//
//  LoginVC.swift
//  EmployerProject
//
//  Created by Marut Tunmanon on 9/23/2559 BE.
//  Copyright © 2559 Marut Tunmanon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
 
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButton(sender: AnyObject) {
        
    
        let username: NSString = txtUsername.text!
        let password: NSString = txtPassword.text!
        
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            alertView("เข้าสู่ระบบไม่สำเร็จ!", msg: "กรุณากรอกข้อมูลให้ครบนะจ๊ะ!")
        }else{
            data_request("http://findcarproject.com/Employer_login1.php", user:username as String, pass:password as String)
            
            //เคลียร์ช่อง text เมื่อเข้าสู่ระบบแล้วกดกลับมาให้เป็นช่องว่าง
            txtUsername.text = ("")
            txtPassword.text = ("")
        }
    }
    
    
    
    func data_request(url:String, user:String, pass:String)
    {
        let parameters = [
            "strUser": user,
            "strPass": pass
        ]
        
        Alamofire.request(.POST, url, parameters: parameters)
            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
                
                if let data = response.result.value { //จากการ request url ไป จะได้กลับมาเป็น string(string เป็น fomat แบบ json เลยต้องทำให้เป็น json)
//                    print("JSON: \(data)")
                    let jsonData = JSON(data) //แปลงข้อมูลเป็น json
                    //print(jsonData)
                    
                    if(jsonData["StatusID"] == "0" ){
                        self.alertView("เข้าสู่ระบบไม่สำเร็จ!", msg: "กรุณากรอกข้อมูลให้ถูกต้องนะจ๊ะ!")
                        
                    }else{
                        let eid = jsonData["Eid"].string //สร้างตัวแปล Tid เพื่อรับค่า Tid ที่ส่งมาแบบ json แปลงเป็น string จากฐานข้อมูลไปใช้
                        // save ข้อมูลลง เครือง ------
                        let defaults = NSUserDefaults.standardUserDefaults()
                        
                        defaults.setValue(eid, forKey: "Eid")
                        
                        defaults.synchronize()
                        
                        self.data_request_sendtoken("http://findcarproject.com/Employer/insertToken.php", id: eid!, token: "asdsadasdasd")
                        //-------------------
                        
                    }
                }
        }
        
    }
    
    func data_request_sendtoken(url:String, id:String, token:String)
    {
        let parameters = [
            "Eid": id,
            "token": token
        ]
        
        Alamofire.request(.POST, url, parameters: parameters)
            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
                
                if let data = response.result.value { //จากการ request url ไป จะได้กลับมาเป็น string(string เป็น fomat แบบ json เลยต้องทำให้เป็น json)
                    //print("JSON: \(data)")
                    let jsonData = JSON(data) //แปลงข้อมูลเป็น json
                    //print(jsonData)
                    
                      self.performSegueWithIdentifier("goto_Home", sender: self)
                    
                }
        }
        
    }
    //func touch เพื่อซ่อน keybord
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    //func สำหรับ alert แสดงข้อความ
    func alertView(title:String,msg:String)
    {
        let myAlert = UIAlertController(title:title,message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title:"ตกลง", style:UIAlertActionStyle.Default, handler:nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated:true, completion:nil)
        
    }

    

   
}


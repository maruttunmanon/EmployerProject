//
//  HomeVC.swift
//  EmployerProject
//
//  Created by Marut Tunmanon on 9/24/2559 BE.
//  Copyright © 2559 Marut Tunmanon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ก่อนจะไปอีกหน้านึงมันจะงมาทำใน prepareForSeque
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_SelectItem" {
            let defaults = NSUserDefaults.standardUserDefaults()
            
            //Code สำหรับแกะ key Eid ที่ส่งมาจากหน้าก่อนมาเก็บไว้ใน stringOne
            if let stringOne = defaults.stringForKey("Eid") {
        
                //ส่ง Url กับค่า กับ eid: stringOne(เป็นแพทเทิร์นตรงกับข้างล่าง) ไปใน func data_request_sendtoken
            data_request_sendtoken("http://www.findcarproject.com/insertItem.php", eid: stringOne)
            }
            
        }
    }
    
    func data_request_sendtoken(url:String, eid:String)
    {
        let parameters = [
            "Eid": eid,
        
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
                    
                    let pid = jsonData["Pid"].string //สร้างตัวแปล Tid เพื่อรับค่า Tid ที่ส่งมาแบบ json แปลงเป็น string จากฐานข้อมูลไปใช้
                    // save ข้อมูลลง เครือง ------
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setValue(pid, forKey: "Pid")
                    
                    defaults.synchronize()
                    //-------------------
                }

                
                    //self.performSegueWithIdentifier("goto_SelectItem", sender: self)
                    
                }
        }
    
    //func touch เพื่อซ่อน keybord
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

        
}

    
    



//
//  ShowDetailTransportVC.swift
//  EmployerProject
//
//  Created by Marut Tunmanon on 9/27/2559 BE.
//  Copyright © 2559 Marut Tunmanon. All rights reserved.
//

import UIKit

class ShowDetailTransportVC: UIViewController {
    
    @IBOutlet weak var labelSource: UITextView!
    @IBOutlet weak var labelSourceDescrip: UILabel!
    @IBOutlet weak var labelDestination: UITextView!
    @IBOutlet weak var labelDestinationDescrip: UILabel!
    @IBOutlet weak var labelCarType: UILabel!
    @IBOutlet weak var labelAssistant: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTime: UILabel!

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //โค๊ดสำหรับแกะข้อมูลเซฟและส่งมาจากหน้าก่อนๆ
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        if let source = defaults.stringForKey("source") { //key
            //print(source) // Some String Value
            labelSource.text! = source
        }
        
        if let destination = defaults.stringForKey("destination") { //key
            //print(destination) // Some String Value
            labelDestination.text! = destination
        }
        
        
        if let sourceDescrip = defaults.stringForKey("sourceDescrip") { //key
            //print(sourceDescrip) // Some String Value
            labelSourceDescrip.text! = sourceDescrip
        }

        
        if let destinationDescrip = defaults.stringForKey("destinationDescrip") { //key
            //print(destinationDescrip) // Some String Value
            labelDestinationDescrip.text! = destinationDescrip
        }
        
        
        if let carType = defaults.stringForKey("carType") { //key
           // print(carType) // Some String Value
            labelCarType.text! = carType
        }
        
        
        if let assistant = defaults.stringForKey("assistant") { //key
            //print(assistant) // Some String Value
            labelAssistant.text! = assistant
        }
        
        if let date = defaults.stringForKey("date") { //key
            //print(date) // Some String Value
            labelDate.text! = date
        }
        
        if let time = defaults.stringForKey("time") { //key
            //print(time) // Some String Value
            labelTime.text! = time
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}

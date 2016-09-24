//
//  SelectCarTypeAndDateVC.swift
//  EmployerProject
//
//  Created by Marut Tunmanon on 9/24/2559 BE.
//  Copyright © 2559 Marut Tunmanon. All rights reserved.
//

import UIKit

class SelectCarTypeAndDateVC: UIViewController {

    
    @IBOutlet weak var labelClickDate: UILabel!
    @IBOutlet weak var labelShowDate: UILabel!
    @IBOutlet weak var labelClickTime: UILabel!
    @IBOutlet weak var labelShowTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelClickDate.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapFunction:"))
        labelClickDate.addGestureRecognizer(tap)
        
        labelClickTime.userInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: Selector("tapFunction2:"))
        labelClickTime.addGestureRecognizer(tap2)
        // Do any additional setup after loading the view.
    }
    func tapFunction(sender:UITapGestureRecognizer) {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            (date) -> Void in
            
            let calendar = NSCalendar.currentCalendar()
            let components = (calendar as NSCalendar).components([.Day , .Month , .Year], fromDate: date!)
            
            let year =  components.year
            let month = components.month
            let day = components.day
            
            print(year)
            print(month)
            print(day)
            self.labelShowDate.text = "\(components.day)/\(components.month)/\(components.year)"
            
            
            //self.labelShowDate.text = "\(date!)"
        }
    }
    
    func tapFunction2(sender:UITapGestureRecognizer) {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Time) {
            (date) -> Void in
            let calendar = NSCalendar.currentCalendar()
            let components = (calendar as NSCalendar).components([.Day , .Month , .Year,.Hour, .Minute], fromDate: date!)
            
            let year =  components.year
            let month = components.month
            let day = components.day
            
            print(year)
            print(month)
            print(day)
            self.labelShowTime.text = "\(components.hour):\(components.minute)"

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//
//  SelectCarTypeAndDateVC.swift
//  EmployerProject
//
//  Created by Marut Tunmanon on 9/24/2559 BE.
//  Copyright © 2559 Marut Tunmanon. All rights reserved.
//

import UIKit

class SelectCarTypeAndDateVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var txtCarType: UITextField!
    @IBOutlet weak var txtAssistant: UITextField!
    
    var year:String = ""
    var month:String = ""
    var day:String = ""
    var hour:String = ""
    var minute:String = ""
    
    
    var rowCar:[String] = [] //สร้าง array เพื่อเก็บค่าใน table rowItem = สร้างไว้เก็บข้อมูล "ประเภทสิ่งของ"
    var carType = ["รถตู้ ", "รถกระบะ ", "รถกระบะมีตู้ ", "รถ 6 ล้อ ", "รถจักรยานยนต์ ", "รถ 10 ล้อ " ]
    var carTypePicker = UIPickerView()
    
    var rowAssistant:[String] = [] //สร้าง array เพื่อเก็บค่าใน table *** rowPiece = สร้างไว้เก็บข้อมูล "จำนวน"
    var assistant = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var assistantPicker = UIPickerView() //เป็นการสร้าง object จาก class UIPickerView() และให้ไปเก็บไว้ใน itemPicker


    
    @IBOutlet weak var labelClickDate: UILabel!
    @IBOutlet weak var labelShowDate: UILabel!
    @IBOutlet weak var labelClickTime: UILabel!
    @IBOutlet weak var labelShowTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    
        labelClickDate.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapFunction:"))
        labelClickDate.addGestureRecognizer(tap)
        
        labelClickTime.userInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: Selector("tapFunction2:"))
        labelClickTime.addGestureRecognizer(tap2)
        
        
        carTypePicker.delegate = self //**เป็น delegate ของมันพอกดเลือกแล้วมันจะไปทำ func ข้างล่าง
        assistantPicker.delegate = self
        
        //ทำการเปลี่ยน inputView ที่ตอนแรกเป็น keybord ให้เป็น PickerView
        txtCarType.inputView = carTypePicker
        txtAssistant.inputView = assistantPicker
            }
    
    //func เวลา โดยเรียกใช้จากคลาสที่เราสร้างชื่อ คลาส DatePickerDialog
    func tapFunction(sender:UITapGestureRecognizer) {
        
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            (date) -> Void in
            
            let calendar = NSCalendar.currentCalendar()
            let components = (calendar as NSCalendar).components([.Day , .Month , .Year], fromDate: date!)
            
            self.year = "\(components.year)" //คำสั่ง "\(....)" คือการทำให้เป็น string
            self.month = "\(components.month)"
            self.day = "\(components.day)"

//            
//            print(year)
//            print(month)
//            print(day)
            self.labelShowDate.text = "\(components.day)/\(components.month)/\(components.year)"
            
            
            //self.labelShowDate.text = "\(date!)"
        }
    }
    
    //func เวลา โดยเรียกใช้จากคลาสที่เราสร้างชื่อ คลาส DatePickerDialog
    func tapFunction2(sender:UITapGestureRecognizer) {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Time) {
            (date) -> Void in
            let calendar = NSCalendar.currentCalendar()
            let components = (calendar as NSCalendar).components([.Day , .Month , .Year,.Hour, .Minute], fromDate: date!)
            
            
            self.hour = "\(components.hour)" //คำสั่ง "\(....)" คือการทำให้เป็น string
            self.minute = "\(components.minute)"
//            print(year)
//            print(month)
//            print(day)
            self.labelShowTime.text = "\(components.hour):\(components.minute)"

        }
    }
    
    //สร้าง PickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    //สร้าง PickerView
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == carTypePicker{
            
            return carType.count
            
        }else{
            return assistant.count
        }
    }
    //สร้าง PickerView ***titleForRow คือ ชื่อ itemtype หรือ piece  ในแต่ละ row
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == carTypePicker{
            return carType[row]
        }else{
            return assistant[row]
        }
    }
    //สร้าง PickerView
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == carTypePicker {
            
            txtCarType.text = carType[row]
            
        }else{
            txtAssistant.text = assistant[row]
        }
        
        //self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //func นี้ไว้สำหรับเมื่อจะเปลี่ยนไปหน้าต่อไปเราจะให้มันทำอะไร
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        segue.destinationViewController as! ShowDetailTransportVC //บอกให้รู้ว่าจะไปหน้าไหน
        
        //เซฟข้อมูลลงเครื่อง
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue(txtCarType.text!, forKey: "carType")
        defaults.setValue(txtAssistant.text!, forKey: "assistant")
        //เป็นการรวม string วันเดือนปี ไว้ในตัวแปร date
        let date:String = "\(day)-\(month)-\(year)"
        defaults.setValue(date, forKey: "date")
        
        let time:String = "\(hour):\(minute)"
        defaults.setValue(time, forKey: "time")
        
        
        defaults.synchronize()
        
    }

    
    
    //func touch เพื่อซ่อน keybord
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
}

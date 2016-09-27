//
//  SelectItemForSendVC.swift
//  EmployerProject
//
//  Created by Marut Tunmanon on 9/24/2559 BE.
//  Copyright © 2559 Marut Tunmanon. All rights reserved.
//

import UIKit

class SelectItemForSendVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate {

  
    @IBOutlet weak var txtSelectItem: UITextField!
    @IBOutlet weak var txtPiece: UITextField!
    @IBOutlet weak var txtOtherItem: UITextField!
    @IBOutlet weak var txtDescriptionItem: UITextField!
    
    @IBOutlet weak var mTable: UITableView!
    var row = 0 // จำนวนของแถว table

    
    var rowDescrip:[String] = []
    
    
    var rowItem:[String] = [] //สร้าง array เพื่อเก็บค่าใน table rowItem = สร้างไว้เก็บข้อมูล "ประเภทสิ่งของ"
    var itemType = ["ตู้", "เตียง", "โต๊ะ", "ทีวี", "ตู้เย็น", "โซฟา" ]
    var itemTypePicker = UIPickerView()
    
    var rowPiece:[String] = [] //สร้าง array เพื่อเก็บค่าใน table *** rowPiece = สร้างไว้เก็บข้อมูล "จำนวน"
    var piece = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var piecePicker = UIPickerView() //เป็นการสร้าง object จาก class UIPickerView() และให้ไปเก็บไว้ใน itemPicker
    
    @IBAction func btnAddItem(sender: AnyObject) {
        
        self.view.endEditing(true) //ทำให้ keybord หายไปเมื่อกดปุ่มเพิ่ม
        //เช็ค if เพื่อใส่ข้อมูลลงใน array
        
        
        if txtSelectItem.text! == "" && txtOtherItem.text! == "" {
            return
        }
        // if !rowItem.contains(txtSelectItem.text!)  //เช็คว่าข้อมูลที่เลือกมันซ้ำรึป่าว
            
            if txtOtherItem.text! != "" { // ถ้า txtItemOther ไม่เท่ากับช่องว่าง
                rowItem.append(txtOtherItem.text!) // ก็ให้แอด txtItemOther ลงใน rowItem เท่ากับเราจะใช้ตัวแปร rowItem อย่างเดียว แทน ขูอมูลในช่อง txtOtherItem
            }else{
                rowItem.append(txtSelectItem.text!) //แต่ถ้า txtItemPicker เท่ากับช่องว่างก็ให้ใส่ txtItemOther
            }
            
            // ใส่ข้อมูลลงใน array
            if txtPiece.text! == "" {
                rowPiece.append("1")
            }else{
                rowPiece.append(txtPiece.text!)
            }
            txtSelectItem.text = ""
            txtPiece.text = ""
            self.row += 1 //แถวใน tableView +1
            mTable.reloadData()
        //append คือคำสั่ง แอดค่า
            rowDescrip.append(txtDescriptionItem.text!)
            txtDescriptionItem.text = ""
            txtOtherItem.text = ""
        }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTypePicker.delegate = self //**เป็น delegate ของมันพอกดเลือกแล้วมันจะไปทำ func ข้างล่าง
        piecePicker.delegate = self
        
        //ทำการเปลี่ยน inputView ที่ตอนแรกเป็น keybord ให้เป็น PickerView
        txtSelectItem.inputView = itemTypePicker
        txtPiece.inputView = piecePicker
        
        self.mTable.separatorStyle = .None  //**ลบเส้นขัน table

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //สร้าง PickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    //สร้าง PickerView
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == itemTypePicker{
            
        return itemType.count
            
        }else{
            return piece.count
        }
    }
    //สร้าง PickerView ***titleForRow คือ ชื่อ itemtype หรือ piece  ในแต่ละ row
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == itemTypePicker{
        return itemType[row]
        }else{
            return piece[row]
        }
    }
    //สร้าง PickerView
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == itemTypePicker {
      
                txtSelectItem.text = itemType[row]
        
        }else{
                txtPiece.text = piece[row]
        }
        
        //self.view.endEditing(true)
    }

    
    // func สำหรับเลื่อนเพื่อลบข้อมูลในตาราง
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
       
        if editingStyle == .Delete{
           
            //let defaults = NSUserDefaults.standardUserDefaults()
            
            //ถ้าเราไม่ใส่ข้างล่างนี้ มันก็จะลบแค่ข้อมูลที่แสดงในตาราง จะไม่ลบข้อมูลใน array จึงต้องใส่โค๊ดข้างล่างเพื่อลบข้อมูลใน array
            rowItem.removeAtIndex(indexPath.row)
            rowPiece.removeAtIndex(indexPath.row)
            rowDescrip.removeAtIndex(indexPath.row)
            //defaults.removeObjectForKey("jobarea\(indexPath.row)") //jobarea คือ key ที่จะ save
            row -= 1
            mTable.reloadData() //เป็นการ refresh ตารางให้เห็นว่าลบข้อมูลแล้ว
        }
    }
    
    //นับแถวตามที่เรา add ค่าลงไปใน tabelView แล้ว return จำนวนแถวให้ tableView ไปสร้างแถว
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return row
    }
    //กำหนดว่าในตารางนี้มี 1 section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //สร้าง cell ตามจำนวนแถว
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1")
        
        cell?.textLabel?.text = "\(rowItem[(indexPath as NSIndexPath).row]) \(rowPiece[(indexPath as NSIndexPath).row]) หน่วย \(rowDescrip[(indexPath as NSIndexPath).row])" //เป็นการแสดงค่าใน array บน cell tableView
        return cell!
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
    
    //func นี้ไว้สำหรับเมื่อจะเปลี่ยนไปหน้าต่อไปเราจะให้มันทำอะไร
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        segue.destinationViewController as! MapVC //บอกให้รู้ว่าจะไปหน้าไหน
        
        //เซฟข้อมูลลงเครื่อง
        let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(rowItem.count, forKey: "itemCount")
     
        
        //สร้าง for วนลูปเพื่อนับข้อมูลที่มีใน array และเก็บค่าลงไปใน keyvalue:
        for i in 0  ..< rowItem.count  {
//            print(rowItem.count)
            defaults.setValue(rowItem[i], forKey: "itemName\(i)")
            defaults.setValue(rowPiece[i], forKey: "itemPiece\(i)")
            defaults.setValue(rowDescrip[i], forKey: "itemDescription\(i)")
            
        }
          defaults.synchronize()
        
    }

    
}

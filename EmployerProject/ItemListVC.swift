//
//  ItemListVC.swift
//  EmployerProject
//
//  Created by Marut Tunmanon on 9/24/2559 BE.
//  Copyright © 2559 Marut Tunmanon. All rights reserved.
//

import UIKit

class ItemListVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate{
    
    var a:Int = 0
    
    @IBOutlet weak var mTable: UITableView!
    
    var itemName = [String]()
    var itemDescription = [String]()
    var itemPiece = [String]()
    var itemOther = [String]()


    @IBAction func takePhotoItem(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func chooseGallery(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.mTable.separatorStyle = .None  //**ลบเส้นขัน table
        
        //โค๊ดสำหรับแกะข้อมูลเซฟและส่งมาจากหน้าก่อนๆ
        let defaults = NSUserDefaults.standardUserDefaults()

        // ดึงค่า key ใน itemcount มาเก็บไว้ใน countt เพื่อจะได้รู้จำนวนค่า count ใน array
        let itemCount = defaults.stringForKey("itemCount")
         a = Int(itemCount!)!
        for i in 0..<a {
            if defaults.stringForKey("itemName\(i)") != nil { //key
                itemName.append(defaults.stringForKey("itemName\(i)")!)
            }
            if defaults.stringForKey("itemPiece\(i)") != nil { //key
                itemPiece.append(defaults.stringForKey("itemPiece\(i)")!)
            }
            if defaults.stringForKey("itemDescription\(i)") != nil { //key
                itemDescription.append(defaults.stringForKey("itemDescription\(i)")!)
            }
        }
        
        print(itemName)
        print(itemPiece)
        print(itemDescription)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.clipsToBounds = true
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //นับแถวตามที่เรา add ค่าลงไปใน tabelView แล้ว return จำนวนแถวให้ tableView ไปสร้างแถว
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return a
    }
    //กำหนดว่าในตารางนี้มี 1 section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //สร้าง cell ตามจำนวนแถว
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        cell?.textLabel?.text = "\(itemName[(indexPath as NSIndexPath).row]) \(itemPiece[(indexPath as NSIndexPath).row]) หน่วย \(itemDescription[(indexPath as NSIndexPath).row])" //เป็นการแสดงค่าใน array บน cell tableView
        return cell!
    }

    
    //func touch เพื่อซ่อน keybord
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


}

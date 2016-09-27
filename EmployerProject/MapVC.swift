//
//  MapVC.swift
//  EmployerProject
//
//  Created by Marut Tunmanon on 9/24/2559 BE.
//  Copyright © 2559 Marut Tunmanon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMaps
class MapVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate,GMSAutocompleteViewControllerDelegate,GMSMapViewDelegate {
    
    @IBOutlet weak var txtSourceProvince: UITextField!
    @IBOutlet weak var txtDestinationProvince: UITextField!
    @IBOutlet weak var txtSourceDescrip: UITextField!
    @IBOutlet weak var txtDestinationDescrip: UITextField!
    
    
    var sourceProvince = ["กรุงเทพมหานคร", "กระบี่", "กาญจนบุรี", "กาฬสินธุ์", "กำแพงเพชร", "ขอนแก่น", "จันทบุรี", "ฉะเชิงเทรา", "ชลบุรี", "ชัยนาท", "ชัยภูมิ", "ชุมพร", "เชียงราย", "เชียงใหม่", "ตรัง", "ตราด", "ตาก", "นครนายก", "นครปฐม", "นครพนม", "นครราชสีมา", "นครศรีธรรมราช", "นครสวรรค์", "นนทบุรี", "นราธิวาส", "น่าน", "บึงกาฬ", "บุรีรัมย์", "ปทุมธานี", "ประจวบคีรีขันธ์", "ปราจีนบุรี", "ปัตตานี", "พระนครศรีอยุธยา", "พังงา", "พัทลุง", "พิจิตร", "พิษณุโลก", "เพชรบุรี", "เพชรบูรณ์", "แพร่", "พะเยา", "ภูเก็ต", "มหาสารคาม", "มุกดาหาร", "แม่ฮ่องสอน", "ยะลา", "ยโสธร", "ร้อยเอ็ด", "ระนอง", "ระยอง", "ราชบุรี", "ลพบุรี", "ลำปาง", "ลำพูน", "เลย", "ศรีสะเกษ", "สกลนคร", "สงขลา", "สตูล", "สมุทรปราการ", "สมุทรสงคราม", "สมุทรสาคร", "สระแก้ว", "สระบุรี", "สิงห์บุรี", "สุโขทัย", "สุพรรณบุรี", "สุราษฎร์ธานี", "สุรินทร์", "หนองคาย" , "หนองบัวลำภู", "อ่างทอง", "อุดรธานี", "อุทัยธานี", "อุตรดิตถ์" , "อุบลราชธานี", "อำนาจเจริญ"]
    var sourceProvincePicker = UIPickerView()
    
    
    var destinationProvince = ["กรุงเทพมหานคร", "กระบี่", "กาญจนบุรี", "กาฬสินธุ์", "กำแพงเพชร", "ขอนแก่น", "จันทบุรี", "ฉะเชิงเทรา", "ชลบุรี", "ชัยนาท", "ชัยภูมิ", "ชุมพร", "เชียงราย", "เชียงใหม่", "ตรัง", "ตราด", "ตาก", "นครนายก", "นครปฐม", "นครพนม", "นครราชสีมา", "นครศรีธรรมราช", "นครสวรรค์", "นนทบุรี", "นราธิวาส", "น่าน", "บึงกาฬ", "บุรีรัมย์", "ปทุมธานี", "ประจวบคีรีขันธ์", "ปราจีนบุรี", "ปัตตานี", "พระนครศรีอยุธยา", "พังงา", "พัทลุง", "พิจิตร", "พิษณุโลก", "เพชรบุรี", "เพชรบูรณ์", "แพร่", "พะเยา", "ภูเก็ต", "มหาสารคาม", "มุกดาหาร", "แม่ฮ่องสอน", "ยะลา", "ยโสธร", "ร้อยเอ็ด", "ระนอง", "ระยอง", "ราชบุรี", "ลพบุรี", "ลำปาง", "ลำพูน", "เลย", "ศรีสะเกษ", "สกลนคร", "สงขลา", "สตูล", "สมุทรปราการ", "สมุทรสงคราม", "สมุทรสาคร", "สระแก้ว", "สระบุรี", "สิงห์บุรี", "สุโขทัย", "สุพรรณบุรี", "สุราษฎร์ธานี", "สุรินทร์", "หนองคาย" , "หนองบัวลำภู", "อ่างทอง", "อุดรธานี", "อุทัยธานี", "อุตรดิตถ์" , "อุบลราชธานี", "อำนาจเจริญ"]
    var destinationProvincePicker = UIPickerView() //เป็นการสร้าง object จาก class UIPickerView() และให้ไปเก็บไว้ใน itemPicker
    
        
    var currenttext:UITextField?
    let path = GMSMutablePath()
    var check = 0;
    @IBOutlet weak var txtsource: UITextField!
    @IBOutlet weak var txtdestination: UITextField!
    @IBOutlet weak var mMap: UIView!
    var mapView:GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.cameraWithLatitude(13.5888,longitude:100.56666, zoom:6)
        mapView = GMSMapView.mapWithFrame(CGRectMake(0, 0, self.mMap.frame.width, self.mMap.frame.height), camera:camera)
        
        mapView?.delegate = self
        
        self.mMap.addSubview(mapView!)
        // Do any additional setup after loading the view.
        txtsource.addTarget(self, action:#selector(MapVC.textDidBeginEditing), forControlEvents: UIControlEvents.TouchDown)
        txtdestination.addTarget(self, action:#selector(MapVC.textDidBeginEditing2), forControlEvents: UIControlEvents.TouchDown)
        
        
        sourceProvincePicker.delegate = self //**เป็น delegate ของมันพอกดเลือกแล้วมันจะไปทำ func ข้างล่าง
        destinationProvincePicker.delegate = self
        
        //ทำการเปลี่ยน inputView ที่ตอนแรกเป็น keybord ให้เป็น PickerView
        txtSourceProvince.inputView = sourceProvincePicker
        txtDestinationProvince.inputView = destinationProvincePicker

               
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
        if pickerView == sourceProvincePicker{
            
            return sourceProvince.count
            
        }else{
            return destinationProvince.count
        }
    }
    //สร้าง PickerView ***titleForRow คือ ชื่อ itemtype หรือ piece  ในแต่ละ row
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sourceProvincePicker{
            return sourceProvince[row]
        }else{
            return destinationProvince[row]
        }
    }
    //สร้าง PickerView
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sourceProvincePicker{
         
            txtSourceProvince.text = sourceProvince[row]
            
        }else{
            txtDestinationProvince.text = destinationProvince[row]
        }
        
        //self.view.endEditing(true)
    }
    
    
    
    
    func textDidBeginEditing()
    {
        currenttext = txtsource
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        self.presentViewController(acController, animated: true, completion: nil)
    }
    func textDidBeginEditing2()
    {
        currenttext = txtdestination
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        self.presentViewController(acController, animated: true, completion: nil)
    }
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        let center = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePicker(config: config)
        
        placePicker.pickPlaceWithCallback({ (place: GMSPlace?, error: NSError?) -> Void in
            if let error = error {
                //print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                
                if self.check == 0 {
                    mapView.clear()
                    self.txtsource.text = place.name
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
                    marker.title = place.name
                    marker.snippet = place.formattedAddress
                    marker.map = mapView
                    self.path.insertCoordinate(CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude), atIndex: 0)
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animateWithCameraUpdate(GMSCameraUpdate.fitBounds(bounds, withPadding: 15.0))
                    self.check = 1
                    
                }else{
                    self.txtdestination.text = place.name
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
                    marker.title = place.name
                    marker.snippet = place.formattedAddress
                    marker.map = mapView
                    marker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
                    self.path.insertCoordinate(CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude), atIndex: 1)
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animateWithCameraUpdate(GMSCameraUpdate.fitBounds(bounds, withPadding: 15.0))
                    self.path.removeAllCoordinates()
                    self.check = 0
                }
                
                
//                
//                print("Place name \(place.name)")
//                print("Place address \(place.formattedAddress)")
//                print("Place attributions \(place.attributions)")
            } else {
//                print("No place selected")
            }
            } as! GMSPlaceResultCallback)
        
        
        

    }
    
    // Handle the user's selection.
    func viewController(viewController: GMSAutocompleteViewController!, didAutocompleteWithPlace place: GMSPlace!) {
//        print("Place name: \(place.name)")
//        print("Place address: \(place.formattedAddress)")
//        print("Place attributions: \(place.attributions)")
        currenttext?.text = place.name
        path.addCoordinate(place.coordinate)
        let marker = GMSMarker()
        marker.position = place.coordinate
        marker.snippet = "Hello World"
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
        if currenttext == txtdestination {
            marker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
        }
        let bounds = GMSCoordinateBounds(path: path)
        
        self.mapView!.animateWithCameraUpdate(GMSCameraUpdate.fitBounds(bounds, withPadding: 15.0))
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func viewController(viewController: GMSAutocompleteViewController!, didFailAutocompleteWithError error: NSError!) {
        // TODO: handle the error.
//        print("Error: \(error.description)")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // User canceled the operation.
    func wasCancelled(viewController: GMSAutocompleteViewController!) {
//        print("Autocomplete was cancelled.")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //func นี้ไว้สำหรับเมื่อจะเปลี่ยนไปหน้าต่อไปเราจะให้มันทำอะไร
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        segue.destinationViewController as! SelectCarTypeAndDateVC //บอกให้รู้ว่าจะไปหน้าไหน
        
        //เซฟข้อมูลลงเครื่อง
        let defaults = NSUserDefaults.standardUserDefaults()
        

        defaults.setValue(txtsource.text!, forKey: "source")
        defaults.setValue(txtdestination.text!, forKey: "destination")
        defaults.setValue(txtSourceProvince.text!, forKey: "sourceProvince")
        defaults.setValue(txtDestinationProvince.text!, forKey: "destinationProvince")
        defaults.setValue(txtSourceDescrip.text!, forKey: "sourceDescrip")
        defaults.setValue(txtDestinationDescrip.text!, forKey: "destinationDescrip")

   
        defaults.synchronize()
        
    }

    
    
    //func touch เพื่อซ่อน keybord
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}
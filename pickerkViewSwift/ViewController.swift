//
//  ViewController.swift
//  pickerkViewSwift
//
//  Created by quy on 5/14/16.
//  Copyright © 2016 quy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,QKCLPickerViewDelegate {
    var pickerView : QKCLPickerView! = nil
   
    @IBOutlet weak var dateTimeButton: UIButton!
    @IBAction func showPicker(sender: AnyObject) {
         pickerView.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView = QKCLPickerView()
        pickerView.delegate = self
       
        print(pickerView.pickerYear)
//        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        myView.backgroundColor = UIColor.redColor()
//        UIApplication.sharedApplication().keyWindow?.addSubview(myView)
        
      
    }
    func donePickerView(pickerView: QKCLPickerView!, selectedIndexMonth: Int, selectedIndexYear: Int) {
        var monthString: String!
        let realMonth = selectedIndexMonth + 1
        if (realMonth < 10 ){
            monthString = "0" + String(realMonth)
        }else{
            monthString = String(realMonth)
        }
       
        let yearString = pickerView.pickerYear[selectedIndexYear] as! String;
        self.dateTimeButton.setTitle(yearString + "/" + monthString, forState: UIControlState.Normal)
        print(yearString + "/" + monthString)
    }
     
}


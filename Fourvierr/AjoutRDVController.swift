//
//  MesRDVViewController.swift
//  Fourviere
//
//  Created by Admin on 16/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import UIKit

class AjoutRDVController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var medecinPicker: UIPickerView!
    var pickerData: [String] = ["Jean Prensouin", "Jay malisi", "Dan tiste", "Mark monpoi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.medecinPicker.delegate = self
        self.medecinPicker.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    

}

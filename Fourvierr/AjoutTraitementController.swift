//
//  AjoutTraitementController.swift
//  Fourviere
//
//  Created by Admin on 24/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import UIKit

class HeureTableCell: UITableViewCell{
    @IBOutlet weak var heureText: UILabel!
    @IBOutlet weak var switchOnOff: UISwitch!
}
class AjoutTraitementController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
  //Texte de type "3 pillule"
    @IBOutlet weak var quantiteTextField: UITextField!
    
    @IBOutlet weak var dateFinTextField: UITextField!
    /////////////
    @IBOutlet weak var traitementPicker: UIPickerView!
    @IBOutlet weak var myTable: UITableView!
    var pickerData: [String] = ["Xanax 200","HyperSomeille","Aspirateurine"]
    let heurePrise = ["6h","7h","8h","9h","10h","11h","12h","13h","14h","15h","16h","17h","18h","19h","20h","21h","22h"]
    let switchValue = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.traitementPicker.delegate = self
        self.traitementPicker.dataSource = self
        createDatePicker()
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
    public func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int{
        return heurePrise.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "priseCell", for: indexPath) as! HeureTableCell
        
        cell.heureText?.text = heurePrise[indexPath.row]
        cell.switchOnOff?.setOn(switchValue[indexPath.row],animated: false)

        return cell
    }
    
    private func setUIEffects(){
        myTable.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        
        myTable.backgroundView = blurEffectView
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        myTable.separatorEffect = vibrancyEffect
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    
    let datePickerDebut = UIDatePicker()
    let datePickerFin = UIDatePicker()
    
    
    func createDatePicker() {
        
        // format for picker
        datePickerDebut.datePickerMode = .date
        datePickerFin.datePickerMode = .date
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        dateFinTextField.inputAccessoryView = toolbar
        
        //assigning date picker to text field
        dateFinTextField.inputView = datePickerFin
        
        
    }
    
    func donePressed() {
        
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFinTextField.text = dateFormatter.string(from: datePickerFin.date)
        self.view.endEditing(true)
    }
    
    
}

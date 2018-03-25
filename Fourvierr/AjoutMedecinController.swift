//
//  MesRDVViewController.swift
//  Fourviere
//
//  Created by Admin on 16/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import UIKit

class AjoutMedecinController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    
    var specialities: [Speciality] = []
    var newDoctor: Doctor?
    
    // MARK: - outlets
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var spePicker: UIPickerView!
    
    // MARK : - view control
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.specialities = SpecialityDAO.getAll()!
        self.spePicker.delegate = self
        self.spePicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK : - Navigation
    
    let doctorValidationSegue = "doctorValidationSegue"
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == self.doctorValidationSegue {
            guard let doctor = addDoctor() else {
                return false
            }
            self.newDoctor = doctor
        }
        return true
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
    
    // MARK : - Actions & functions
    
    func addDoctor() -> Doctor? {
        
        // Get all the optionnal fields
        let lastName = nameField.text
        let address = addressField.text
        let phone = phoneField.text
        let firstName = firstNameField.text
        let speciality = specialities[spePicker.selectedRow(inComponent: 0)]
        
        // Check mandatory fields
        if lastName?.isEmpty ?? true {
            let alert = UIAlertController(title: "Nom manquant", message: "Le nom de famille est obligatoire", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title:"retour", style: .default)
            alert.addAction(cancelAction)
            present(alert, animated: true)
            
            // Discard Adding
            return nil
        }
        
        // return it
        return Doctor(lastName: lastName!, speciality: speciality, firstName: firstName, phoneNumber: phone, address: address)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return specialities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return specialities[row].label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
}

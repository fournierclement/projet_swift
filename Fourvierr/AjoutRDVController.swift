//
//  MesRDVViewController.swift
//  Fourviere
//
//  Created by Admin on 16/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import UIKit

class AjoutRDVController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    // MARK: - outlets & var
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var medecinPicker: UIPickerView!

    var doctors: [Doctor] = []
    
    // MARK: - view control
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doctors = DoctorDAO.getAll()!
        self.medecinPicker.delegate = self
        self.medecinPicker.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
    }
    // MARK: - Navigation
    
    let appointmentValidationSegue = "appointmentValidationSegue"
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == appointmentValidationSegue {
            guard (addAppointment() != nil) else {
                return false
            }
        }
        return true
    }
    
    // MARK: - Actions & functions
    
    func addAppointment() -> Appointment? {
        let date = datePicker.date
        let doctor = doctors[medecinPicker.selectedRow(inComponent: 0)]
        return Appointment(date: date, doctor: doctor)
    }
    
    // MARK: - Picker functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return doctors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return doctors[row].toString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    

}

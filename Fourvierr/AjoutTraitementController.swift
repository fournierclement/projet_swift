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
    let dateFormatter = DateFormatter()
    /////////////
    @IBOutlet weak var traitementPicker: UIPickerView!
    @IBOutlet weak var myTable: UITableView!
    var medecines: [Medecine] = []
    
    // Doses can be without those hours and so there is that many switcher
    let heuresPrises: [String] = Dose.dailyHours
    var heuresPrisesSwitch: [Bool] = Dose.dailyHours.map { _ in false }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.medecines = MedecineDAO.getAll()!
        self.traitementPicker.delegate = self
        self.traitementPicker.dataSource = self
        self.dateFormatter.dateFormat = "dd/MM/yyyy"
        let nextYearDate = Date().addingTimeInterval(60 * 60 * 24 * 365)
        self.dateFinTextField.text = self.dateFormatter.string(from: nextYearDate)
        createDatePicker()
    }

    // MARK: - Medecine Picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return medecines.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return medecines[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    // MARK: - Table of switch
    
    public func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int{
        return heuresPrises.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "priseCell", for: indexPath) as! HeureTableCell
        
        // MARK: Switch generation
        
        cell.heureText?.text = self.heuresPrises[indexPath.row]
        cell.switchOnOff?.setOn(self.heuresPrisesSwitch[indexPath.row],animated: false)
        cell.switchOnOff.tag = indexPath.row
        cell.switchOnOff.addTarget(self, action: #selector(switchHeuresPrises), for: .allTouchEvents)

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
    
    // MARK: - Functions
    
    func switchHeuresPrises(sender: UISwitch) {
        self.heuresPrisesSwitch[sender.tag] = !self.heuresPrisesSwitch[sender.tag]
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
    
    func addTreatment() -> Treatment? {
        let medecine = self.medecines[traitementPicker.selectedRow(inComponent: 0)]
        let quantity = self.quantiteTextField.text
        let endDate = dateFormatter.date(from: self.dateFinTextField.text!)
        let hours = heuresPrises.enumerated().filter {
                (index, hour) in return self.heuresPrisesSwitch[index]
            }.map {(index, hour) in return hour }
        guard !(quantity?.isEmpty)! && hours.count > 0 else {
            let alert = UIAlertController(title: "champs manquant", message: "Il faut une quantité et au minimum une heure de prise.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title:"retour", style: .default)
            alert.addAction(cancelAction)
            present(alert, animated: true)
            return nil
        }
        return Treatment(medecine: medecine, quantity: quantity!, endDate: endDate!, hours: hours)
    }
    
    // MARK: - Navigation
    
    let treatmentValidation = "treatmentValidation"
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == self.treatmentValidation) {
            guard addTreatment() != nil else {
                return false
            }
        }
        return true
    }
    
}

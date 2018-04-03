//
//  AjoutTraitementController.swift
//  Fourviere
//
//  Created by Admin on 24/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import UIKit

class ActiviteeTableCell: UITableViewCell{
    
    @IBOutlet weak var jourText: UILabel!
    @IBOutlet weak var switchOnOff: UISwitch!

}
class AjoutActiviteeController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var exercicePicker: UIPickerView!
    @IBOutlet weak var myTable: UITableView!
    
    var pickerData: [Exercice] = []
    var selectedExercice: Exercice?
    let joursExercices: [String] = Exercice.days
    var joursExercicesSwitch: [Bool] = Exercice.days.map { _ in false }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exercicePicker.delegate = self
        self.exercicePicker.dataSource = self
        self.pickerData = ExerciceDAO.getAll()!
        self.selectedExercice = pickerData.first
        if self.selectedExercice != nil {
            self.joursExercicesSwitch = self.joursExercices.map{self.selectedExercice!.mustWork(this: $0)}
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
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
    
    // MARK: - Picker func
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].toString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedExercice = pickerData[row]
        self.joursExercicesSwitch = self.joursExercices.map{self.selectedExercice!.mustWork(this: $0)}
        self.myTable.beginUpdates()
        self.myTable.reloadRows(at: self.myTable.indexPathsForVisibleRows!, with: UITableViewRowAnimation.automatic )
        self.myTable.endUpdates()
    }
    
    // MARK: - Table func
    public func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int{
        return joursExercices.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "priseCell", for: indexPath) as! ActiviteeTableCell
        cell.jourText?.text = self.joursExercices[indexPath.row]
        cell.switchOnOff?.setOn(self.joursExercicesSwitch[indexPath.row],animated: false)
        cell.switchOnOff?.tag = indexPath.row
        cell.switchOnOff?.addTarget(self, action: #selector(doSwitch), for: .allTouchEvents)
        return cell
    }
    
    // MARK: - Functions
    
    func doSwitch(sender: UISwitch) {
        // If + so the day was already here
        guard self.selectedExercice != nil else { return }
        if (self.joursExercicesSwitch[sender.tag]) {
            self.selectedExercice!.removeWorkingDay(day: joursExercices[sender.tag])
        } else {
            self.selectedExercice!.addWorkingDay(day: joursExercices[sender.tag])
        }
        // Maybe a bit overkill
        self.joursExercicesSwitch = self.joursExercices.map{self.selectedExercice!.mustWork(this: $0)}
    }
    
    @IBAction func ajoutExercice(_ sender: UIButton) {
        let alert = UIAlertController(title: "Nouvel exercice", message: "Entrez l'intitulé de l'exercice :", preferredStyle: .alert)
        let addExercice = UIAlertAction(title:"confirmer", style: .default)
        {
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                !(textField.text?.isEmpty)! else {
                    return
            }
            self.pickerData.append(Exercice(entitled: textField.text!))
            self.exercicePicker.reloadAllComponents()
            
        }
        let cancelAction = UIAlertAction(title:"retour", style: .default)
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(addExercice)
        present(alert, animated: true)
    }
}

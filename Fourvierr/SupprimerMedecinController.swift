//
//  SupprimerMedecinController.swift
//  Fourviere
//
//  Created by l on 03/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
import UIKit

class MedecinCell: UITableViewCell{
    
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var prenomLabel: UILabel!
    @IBOutlet weak var speLabel: UILabel!

}
class SupprimerMedecinController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTable: UITableView!
    
    var doctors : [Doctor] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doctors = DoctorDAO.getAll()!
        setUIEffects()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int{
        return self.doctors.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "medecinCell", for: indexPath) as! MedecinCell
        cell.nomLabel?.text = doctors[indexPath.row].lastName
        cell.prenomLabel?.text = doctors[indexPath.row].firstName
        cell.speLabel?.text = doctors[indexPath.row].speciality
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
    
    public func tableView(_ tableView: UITableView, commit EditingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        // On delete
        if(EditingStyle == UITableViewCellEditingStyle.delete) {
            self.myTable.beginUpdates();
            DoctorDAO.delete(doctor: doctors[indexPath.row])
            self.doctors.remove(at: indexPath.row)
            self.myTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            self.myTable.endUpdates()
        }
    }
    
}

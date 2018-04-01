//
//  MesRDVViewController.swift
//  Fourviere
//
//  Created by Admin on 16/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import UIKit

class RdvTableCell: UITableViewCell{
    @IBOutlet weak var heureLabel: UILabel!
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}
class MesRDVViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTable: UITableView!
    var appointments : [Appointment] = []
    
    @IBOutlet weak var dateAujourdhuiLabel: UILabel!

    // MARK: - Our App is the prettiest
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appointments = AppointmentDAO.getAll()!
        setUIEffects()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUIEffects(){
        
        let date = Date()
        let calendar = Calendar.current
        dateAujourdhuiLabel.text = String(calendar.component(.day, from: date))
        
        
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
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Table View func
    
   public func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int{
    return self.appointments.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "rdvCell", for: indexPath) as! RdvTableCell

        cell.heureLabel?.text = appointments[indexPath.row].hour
        cell.dateLabel?.text = appointments[indexPath.row].day
        cell.nomLabel?.text = appointments[indexPath.row].doctor.toString
        return cell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, commit EditingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        // On delete
        if(EditingStyle == UITableViewCellEditingStyle.delete) {
            self.myTable.beginUpdates();
            AppointmentDAO.delete(appointment: appointments[indexPath.row])
            self.appointments.remove(at: indexPath.row)
            self.myTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            self.myTable.endUpdates()
        }
    }
    
    // MARK: - Nagivation
    
    @IBAction func unwindToRDV(segue:UIStoryboardSegue) {
        self.appointments = AppointmentDAO.getAll()!
        myTable.reloadData()
    }
    
    let detailsAppointment = "detailsAppointment"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == self.detailsAppointment)	{
            if let indexPath = self.myTable.indexPathForSelectedRow {
                let showDoctorDetails = segue.destination as! VoirMedecinController
                showDoctorDetails.appointment = self.appointments[indexPath.row]
            }
        }
    }
}

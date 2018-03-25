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
    

}

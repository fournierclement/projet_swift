//
//  VoirMedecinController.swift
//  Fourviere
//
//  Created by Admin on 27/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import UIKit

class VoirMedecinController: UIViewController{
    
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var prenomLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var speLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var heureLabel: UILabel!
    
    var appointment: Appointment?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ( self.appointment != nil ){
            self.dateLabel.text = self.appointment!.day
            self.heureLabel.text = self.appointment!.hour
            if let doctor = self.appointment?.doctor {
                self.nomLabel.text = doctor.lastName
                self.prenomLabel.text = doctor.firstName!
                self.telLabel.text = doctor.address!
                self.speLabel.text = doctor.speciality!
            }
        }
    }
    
}

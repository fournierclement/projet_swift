//
//  VoirMedecinController.swift
//  Fourviere
//
//  Created by Admin on 27/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import UIKit

class VoirMedecinController: UIViewController{
    
    //Todo les mettre a jour avec les valeurs du medein dont provient le click
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var prenomLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var speLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
}

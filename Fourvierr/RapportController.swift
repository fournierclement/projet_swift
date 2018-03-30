//
//  RapportController.swift
//  Fourviere
//
//  Created by Admin on 30/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import UIKit

class RapportController: UIViewController{
    
    @IBOutlet weak var dateSelector: UISegmentedControl!
    @IBOutlet weak var tauxReponse: UILabel!
    @IBOutlet weak var tauxPriseMedoc: UILabel!
    @IBOutlet weak var tauxDeDisquinesie: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //TODO
    //Mettre a jour les taux en fonction du segment
    
}

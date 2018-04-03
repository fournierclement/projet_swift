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
    @IBOutlet weak var tauxDeDyskinesie: UILabel!
    
    var rapports : [Rapport] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rapports = [Rapport(), Rapport(), Rapport(), Rapport(), Rapport()]
        let index = dateSelector.selectedSegmentIndex;
        self.tauxReponse.text = self.rapports[index].tauxReponse
        self.tauxPriseMedoc.text = self.rapports[index].tauxPriseMedoc
        self.tauxDeDyskinesie.text = self.rapports[index].tauxDeDyskinesie
    }
    
    @IBAction func changeJour(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex;
        self.tauxReponse.text = self.rapports[index].tauxReponse
        self.tauxPriseMedoc.text = self.rapports[index].tauxPriseMedoc
        self.tauxDeDyskinesie.text = self.rapports[index].tauxDeDyskinesie
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

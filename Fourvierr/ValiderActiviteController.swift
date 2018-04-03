//
//  validerActiviteController.swift
//  Fourviere
//
//  Created by Admin on 27/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//


import UIKit

class ValiderActiviteController: UIViewController{
    
    let ActivityDone = "ActivityDone"
    var exercice: Exercice?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if( identifier == self.ActivityDone) {
            self.exercice!.setDone()
        }
        return true
    }
    
}

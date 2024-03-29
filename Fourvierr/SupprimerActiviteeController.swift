//
//  MesRDVViewController.swift
//  Fourviere
//
//  Created by Admin on 16/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import UIKit

class ActiviteeCell: UITableViewCell{
    
    @IBOutlet weak var nomLabel: UILabel!
}
class SupprimerActiviteeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTable: UITableView!
    
    var exercices : [Exercice] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exercices = ExerciceDAO.getAll()!
        setUIEffects()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int{
        return self.exercices.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "actCell", for: indexPath) as! ActiviteeCell
        
        cell.nomLabel?.text = exercices[indexPath.row].toString
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
            ExerciceDAO.delete(exercice: exercices[indexPath.row])
            self.exercices.remove(at: indexPath.row)
            self.myTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            self.myTable.endUpdates()
        }
    }
}

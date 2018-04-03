//
//  MesRDVViewController.swift
//  Fourviere
//
//  Created by Admin on 16/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import UIKit

class MedocsTableCell: UITableViewCell{
    
    @IBOutlet weak var heureLabel: UILabel!
    @IBOutlet weak var qttLabel: UILabel!
    @IBOutlet weak var medLabel: UILabel!
}

class MedocsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTable: UITableView!
    var doses : [Dose] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIEffects()
        let now = Date()
        self.doses = DoseDAO.getDailyDoses().filter({$0.time >= now})
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.navigationController?.isNavigationBarHidden = true
        let now = Date()
        self.doses = DoseDAO.getDailyDoses().filter({$0.time >= now})
        myTable.reloadData()
    }
    
    // MARK: - Table
    public func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int{
        return doses.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "medocCell", for: indexPath) as! MedocsTableCell
        
        cell.heureLabel?.text = self.doses[indexPath.row].hour
        cell.qttLabel?.text = self.doses[indexPath.row].quantity
        cell.medLabel?.text = self.doses[indexPath.row].medecine
        return cell
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToMedocs(segue: UIStoryboardSegue){
    }
}

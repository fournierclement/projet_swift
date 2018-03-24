//
//  MesRDVViewController.swift
//  Fourviere
//
//  Created by Admin on 16/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import UIKit

class MedocsTableCell: UITableViewCell{
    
}

class MedocsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTable: UITableView!
    let dateTest = ["08-12","09-11", "12-11"]
    let heureTest = ["14h","17h30", "11h"]
    let nomTest = ["Orthophoniste delaré","Dentiste DODO", "Kiné Zitérapete"]
    
    @IBOutlet weak var dateAujourdhuiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIEffects()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int{
        return nomTest.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "medocCell", for: indexPath) as! RdvTableCell
        
        cell.heureLabel?.text = heureTest[indexPath.row]
        cell.dateLabel?.text = dateTest[indexPath.row]
        cell.nomLabel?.text = nomTest[indexPath.row]
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

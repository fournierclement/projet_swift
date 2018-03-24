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
    let qttTest = ["1 comprimé","2 cuillère", "5 piqure"]
    let heureTest = ["14h","17h30", "11h"]
    let nomTest = ["Nespresso to cure my depresso", "Xanax 1000", "Oublipa pills 200"]
    
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "medocCell", for: indexPath) as! MedocsTableCell
        
        cell.heureLabel?.text = heureTest[indexPath.row]
        cell.qttLabel?.text = qttTest[indexPath.row]
        cell.medLabel?.text = nomTest[indexPath.row]
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
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
}

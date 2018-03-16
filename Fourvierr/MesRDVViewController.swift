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

    let dateTest = ["08-12","09-11", "12-11"]
    let heureTest = ["14h","17h30", "11h"]
    let nomTest = ["Orthophoniste delaré","Dentiste DODO", "Kiné Zitérapete"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "rdvCell", for: indexPath) as! RdvTableCell

        cell.heureLabel?.text = heureTest[indexPath.row]
        cell.dateLabel?.text = dateTest[indexPath.row]
        cell.nomLabel?.text = nomTest[indexPath.row]
        return cell
    }

}

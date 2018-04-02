//
//  SportController.swift
//  Fourviere
//
//  Created by Admin on 27/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
import UIKit

class SportCell: UITableViewCell{
    
    @IBOutlet weak var activiteLabel: UILabel!
    @IBOutlet weak var expLabel: UILabel!
}
class SportController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TitreHonorifiqueLabel: UILabel!
    @IBOutlet weak var expDuNiveauLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var myTable: UITableView!
    var exercices : [Exercice] = []
    
    @IBOutlet weak var dateAujourdhuiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIEffects()
        self.exercices = ExerciceDAO.getTodayExercices()!
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! SportCell
        
        cell.expLabel?.text = "\(exercices[indexPath.row].exp)exp"
        cell.activiteLabel?.text = exercices[indexPath.row].toString
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
    
    // MARK: - Navigation
    
    @IBAction func unwindToExercices(segue:UIStoryboardSegue) {
        self.exercices = ExerciceDAO.getTodayExercices()!
        self.myTable.reloadData()
    }
    
}

//
//  Rapport.swift
//  Fourviere
//
//  Created by l on 03/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class Rapport {
    init(){}
    static let days = [-1,-2,-3,-4,-5]
    static let hours = [8,10,12,14,16,18,20,22]
    
    var date: Date {
        return Date()
    }
    var tauxReponse: String {
        return "\(arc4random_uniform(100))%"
    }
    var tauxPriseMedoc: String {
        return "\(arc4random_uniform(100))%"
    }
    var tauxDeDyskinesie: String {
        return "\(arc4random_uniform(100))%"
    }
    
    func addNonResponse(){
        
    }
    func addDoseResponse(taken: Bool){
        
    }
    func addDyskinesie(dyskinesie: Bool){
        
    }
    
    
}

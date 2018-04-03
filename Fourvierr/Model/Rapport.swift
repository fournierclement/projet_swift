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
}

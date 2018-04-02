//
//  Activity.swift
//  Fourviere
//
//  Created by l on 02/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class Activity {
//    internal var dto : ActivityDTO
//    internal init(dto: ActivityDTO){
//        self.dto = dto
//    }
//
//    @discardableResult
//    init(exercice: Exercice, days:[String]){
//        if let dto = ActivityDAO.search(exercice: exercice) {
//            self.dto = dto
//        } else {
//            self.dto = ActivityDAO.create(exercice: exercice, days: days)
//        }
//    }
    static let days: [String] = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
    var hour: String {
        return "09:00"
    }
    var exp: String {
        return "\(140)exp"
    }
    var exercice: String {
        return "5 enjambées de salades"
    }
}

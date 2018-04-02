//
//  Exercices.swift
//  Fourviere
//
//  Created by l on 02/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class Exercice {
    static let days: [String] = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
    internal var dto : ExerciceDTO
    internal init(dto: ExerciceDTO) {
        self.dto = dto
    }
    
    
    // Dont know what to do with xp yet
    public private(set) var exp: UInt32 = arc4random_uniform(200)
    
    @discardableResult
    init(entitled: String){
        if let dto = ExerciceDAO.search(entitled: entitled) {
            self.dto = dto
        } else {
            self.dto = ExerciceDAO.create(entitled: entitled)
        }
    }
    
    func addWorkingDay(day: String) {
        ExerciceDAO.add(me:self, workingDay: day)
    }
    func removeWorkingDay(day: String) {
        ExerciceDAO.remove(me: self, workingDay: day)
    }
    
    var entitled: String {
        return self.dto.entitled!
    }
    
    func mustWork(this day: String) -> Bool {
        return (self.dto.workingDays!.contains(day))
    }
    
    var toString: String {
        return self.dto.entitled!
    }
}

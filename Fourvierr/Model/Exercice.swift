//
//  Exercices.swift
//  Fourviere
//
//  Created by l on 02/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class Exercice {
    static let days: [String] = ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"]
    static var today: String {
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: Date())
        let weekDay = myComponents.weekday
        return days[weekDay! - 1]
    }
    
    
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
    var lastDone: Date? {
        if ( self.dto.lastDone != nil ) {
            return Date(timeIntervalSince1970: self.dto.lastDone!.timeIntervalSince1970)
        }
        return nil
    }
    
    func mustWork(this day: String) -> Bool {
        return (self.dto.workingDays!.contains(day))
    }
    
    var toString: String {
        return self.dto.entitled!
    }
    
    func toDo() -> Bool {
        let isDone = self.lastDone != nil && ( Date() < self.lastDone! )
        return self.mustWork(this: Exercice.today) && !isDone
    }
    func setDone(){
        ExerciceDAO.setDone(exercice: self)
    }
}

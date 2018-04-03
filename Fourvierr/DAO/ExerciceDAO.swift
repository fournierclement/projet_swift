//
//  ExerciceDAO.swift
//  Fourviere
//
//  Created by l on 02/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
import CoreData

class ExerciceDAO {
    static let request : NSFetchRequest<ExerciceDTO> = ExerciceDTO.fetchRequest()
    
    // MARK: - Exercice Initialization
    
    static func initialize () {
        Exercice(entitled: "Enjambées de salades")
        Exercice(entitled: "Série de Pompes à huile")
        Exercice(entitled: "Ab' domino's pizza")
    }
    
    // MARK: - Exercice Functions
    static func search (entitled: String) -> ExerciceDTO? {
        self.request.predicate = NSPredicate(format: "entitled == %@", entitled )
        do {
            let exercices = try CoreDataManager.context.fetch(request) as [ExerciceDTO]
            guard exercices.count > 0 else { return nil }
            return exercices[0]
            
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func create (entitled: String) -> ExerciceDTO {
        let dto = ExerciceDTO(context: CoreDataManager.context)
        dto.entitled = entitled
        dto.workingDays = []
        CoreDataManager.save()
        return dto
    }
    
    static func add(me: Exercice, workingDay: String) {
        me.dto.workingDays?.insert(workingDay)
        CoreDataManager.save()
    }
    static func remove(me: Exercice, workingDay: String) {
        me.dto.workingDays?.remove(workingDay)
        CoreDataManager.save()
    }
    static func setDone(exercice: Exercice) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd:"
        let todayString = dateFormatter.string(from: Date())
        dateFormatter.dateFormat = "yyyy:MM:dd:HH:mm:ss"
        let tonightDate = dateFormatter.date(from: todayString + "23:59:59")!
        exercice.dto.lastDone = tonightDate
        CoreDataManager.save()
    }
    
    
    static func getAll() -> [Exercice]? {
        self.request.predicate = nil
        let sort = NSSortDescriptor(key:"entitled", ascending: true)
        self.request.sortDescriptors = [sort]
        do{
            let exercicesDTO = try CoreDataManager.context.fetch(self.request)
            return exercicesDTO.map { Exercice(dto:$0)}
        }
        catch{
            return []
        }
    }
    
    static func getTodayExercices() -> [Exercice]? {
        
        self.request.predicate = nil
        let sort = NSSortDescriptor(key:"entitled", ascending: true)
        self.request.sortDescriptors = [sort]
        do{
            let exercicesDTO = try CoreDataManager.context.fetch(self.request)
            return exercicesDTO.map { Exercice(dto:$0)} .filter { $0.toDo() }
        }
        catch{
            return []
        }
    }
    
    static func delete(exercice: Exercice){
        CoreDataManager.context.delete(exercice.dto)
        CoreDataManager.save()
    }
}


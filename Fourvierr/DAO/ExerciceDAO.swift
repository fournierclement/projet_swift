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
        return dto
    }
    
    static func add(me: Exercice, workingDay: String) {
        me.dto.workingDays?.insert(workingDay)
    }
    static func remove(me: Exercice, workingDay: String) {
        me.dto.workingDays?.remove(workingDay)
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
        
        self.request.predicate = nil //NSPredicate(format: "workingDays contains %@", )
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
    
    static func delete(exercice: Exercice){
        CoreDataManager.context.delete(exercice.dto)
    }
}


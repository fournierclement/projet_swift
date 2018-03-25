//
//  SpecialityDAO.swift
//  Fourviere
//
//  Created by l on 25/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
import CoreData

class SpecialityDAO {
    static let request : NSFetchRequest<SpecialityDTO> = SpecialityDTO.fetchRequest()

    // MARK : - Speciality Initialization
    
    static func initialize () {
        Speciality(label: "Autre")
        Speciality(label: "Neurologue")
        Speciality(label: "Généraliste")
        Speciality(label: "Psychiatre")
        Speciality(label: "Kinésithérapeute")
    }
    
    // MARK : - Doctor Function
    static func search (label: String) -> SpecialityDTO? {
        self.request.predicate = NSPredicate(format: "label == %@", label )
        do {
            let specialities = try CoreDataManager.context.fetch(request) as [SpecialityDTO]
            guard specialities.count > 0 else { return nil }
            return specialities[0]
            
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func create (label: String) -> SpecialityDTO {
        let dto = SpecialityDTO(context: CoreDataManager.context)
        dto.label = label
        return dto
    }
    
    static func getAll() -> [Speciality]? {
        self.request.predicate = nil
        do{
            let specialitiesDTO = try CoreDataManager.context.fetch(self.request)
            return specialitiesDTO.map { Speciality(dto:$0)}
        }
        catch{
            return []
        }
    }
}

//
//  MedecineDAO.swift
//  Fourviere
//
//  Created by l on 25/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
//
//  MedecineDAO.swift
//  Fourviere
//
//  Created by l on 25/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
//
//  MedecineDAO.swift
//  Fourviere
//
//  Created by l on 25/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
import CoreData

class MedecineDAO {
    static let request : NSFetchRequest<MedecineDTO> = MedecineDTO.fetchRequest()
    
    // MARK: - Medecine Initialization
    
    static func initialize () {
        Medecine(name: "Xanax", descriptus: "Zats something to make you feel goooooooood")
        Medecine(name: "Aspirine", descriptus: "When Billy is too loud")
        Medecine(name: "Magnetisme", descriptus: "Funny stones to feel zen")
        Medecine(name: "Psycotropes", descriptus: "Make you discover new colors")
        Medecine(name: "Omae wa pathie", descriptus: "Dat thing to make you believe it does something")
    }
    
    // MARK: - Medecine Functions
    static func search (name: String) -> MedecineDTO? {
        self.request.predicate = NSPredicate(format: "name == %@", name )
        do {
            let medecines = try CoreDataManager.context.fetch(request) as [MedecineDTO]
            guard medecines.count > 0 else { return nil }
            return medecines[0]
            
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func create (name: String, descriptus: String?) -> MedecineDTO {
        let dto = MedecineDTO(context: CoreDataManager.context)
        dto.name = name
        dto.descriptus = descriptus
        return dto
    }
    
    static func getAll() -> [Medecine]? {
        self.request.predicate = nil
        let sort = NSSortDescriptor(key:"name", ascending: true)
        self.request.sortDescriptors = [sort]
        do{
            let medecinesDTO = try CoreDataManager.context.fetch(self.request)
            return medecinesDTO.map { Medecine(dto:$0)}
        }
        catch{
            return []
        }
    }
}


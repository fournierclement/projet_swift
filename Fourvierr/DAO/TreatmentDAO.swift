//
//  TreatmentDAO.swift
//  Fourviere
//
//  Created by l on 01/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
import CoreData

class TreatmentDAO {
    static let request : NSFetchRequest<TreatmentDTO> = TreatmentDTO.fetchRequest()
    
    // MARK: - Treatments Initialization
    
    static func initialize () {
        let nextYear = Date().addingTimeInterval(60*60*24*360)
        Treatment(medecine: Medecine(name: "Xanax", descriptus: nil), quantity: "2 pillules", endDate: nextYear, hours: ["12:00"])
        Treatment(medecine: Medecine(name: "Trowa 100", descriptus: nil), quantity: "1 Cuillière", endDate: nextYear, hours: ["15:00"])
        Treatment(medecine: Medecine(name: "Psycotropes", descriptus: nil), quantity: "0.5 Gram", endDate: nextYear, hours: ["20:00"])
        Treatment(medecine: Medecine(name: "Omae wa pathie", descriptus: nil), quantity: "3 Piqures", endDate: nextYear, hours: ["9:00"])
    }

    static func search(medecine: Medecine, quantity: String) -> TreatmentDTO? {
        self.request.predicate = NSPredicate(format: "takes.name == %@ AND quantity == %@", medecine.name, quantity)
        do {
            let treatments = try CoreDataManager.context.fetch(request) as [TreatmentDTO]
            guard treatments.count > 0 else { return nil }
            return treatments[0]
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }

    static func create(medecine: Medecine, quantity: String, endDate: Date, hours: [String]) -> TreatmentDTO {
        let dto = TreatmentDTO(context: CoreDataManager.context)
        dto.takes = medecine.dto
        dto.quantity = quantity
        dto.endDate = endDate as NSDate
        dto.hours = Set<String>(hours.map {$0})
        return dto
    }
    
    static func getAll() -> [Treatment]? {
        self.request.predicate = NSPredicate(format: "endDate >= %@", Date() as CVarArg)
        let sort = NSSortDescriptor(key:"endDate", ascending: true)
        self.request.sortDescriptors = [sort]
        do{
            let treatmentsDTO = try CoreDataManager.context.fetch(self.request)
            return treatmentsDTO.map { Treatment(dto:$0)}
        }
        catch{
            return []
        }
    }
    static func delete(treatment: Treatment){
        CoreDataManager.context.delete(treatment.dto)
    }
}

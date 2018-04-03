//
//  DoctorDAO.swift
//  Fourviere
//
//  Created by l on 20/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
import CoreData

class DoctorDAO {
    static let request : NSFetchRequest<DoctorDTO> = DoctorDTO.fetchRequest()
    
    // MARK: - Doctor Initialization
    
    static func initialize () {
        Doctor(lastName: "Smith", speciality: Speciality(label: "Neurologue"), firstName: "Jean", phoneNumber:"00", address:"here")
        Doctor(lastName: "Dude", speciality: Speciality(label: "Psychiatre"), firstName: "John", phoneNumber:"01", address:"there")
    }
    
    // MARK: - Doctor Functions
    
    static func search (lastName: String, speciality: Speciality) -> DoctorDTO? {
        self.request.predicate = NSPredicate(format: "lastName == %@ AND practices.label == %@", lastName, speciality.label )
        do{
            let doctors = try CoreDataManager.context.fetch(request) as [DoctorDTO]
            guard doctors.count > 0 else { return nil }
            return doctors[0]
            
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func create (lastName: String, speciality: Speciality, firstName: String?, phoneNumber: String?, address: String?) -> DoctorDTO {
        let dto = DoctorDTO(context: CoreDataManager.context);
        dto.lastName = lastName
        dto.setValue(speciality.dto, forKey: "practices")
        dto.firstName = firstName
        dto.address = address
        dto.phoneNumber = phoneNumber
        return dto
    }
    
    static func getAll() -> [Doctor]? {
        self.request.predicate = nil
        let sort1 = NSSortDescriptor(key:"practices.label", ascending: true)
        let sort2 = NSSortDescriptor(key:"lastName", ascending: true)
        self.request.sortDescriptors = [sort1, sort2]
        do{
            let DoctorsDTO = try CoreDataManager.context.fetch(self.request)
            return DoctorsDTO.map { Doctor(dto:$0)}
        }
        catch{
            return []
        }
    }
    static func delete(doctor: Doctor){
        CoreDataManager.context.delete(doctor.dto)
    }
}

//
//  AppointmentDAO.swift
//  Fourviere
//
//  Created by l on 25/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
import CoreData

class AppointmentDAO {
    static let request : NSFetchRequest<AppointmentDTO> = AppointmentDTO.fetchRequest()
    
    // MARK: - Appointment Initialization
    
    static func initialize () {
        Appointment(date:Date(), doctor: Doctor(lastName:"Smith", speciality: Speciality(label:"Neurologue")))
    }
    
    // MARK: - Appointment Functions
    
    static func search (date: Date, doctor: Doctor) -> AppointmentDTO? {
        self.request.predicate = NSPredicate(format: "date == %@ AND to_Meet.lastName == %@ AND to_Meet.practices.label == %@", date as CVarArg, doctor.lastName, doctor.speciality! )
        do{
            let appointments = try CoreDataManager.context.fetch(request) as [AppointmentDTO]
            guard appointments.count > 0 else { return nil }
            return appointments[0]
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func create (date: Date, doctor: Doctor) -> AppointmentDTO {
        let dto = AppointmentDTO(context: CoreDataManager.context);
        dto.date = date as NSDate
        dto.setValue(doctor.dto, forKey: "to_Meet")
        CoreDataManager.save()
        return dto
    }
    
    static func getAll() -> [Appointment]? {
        self.request.predicate = nil
        let sort = NSSortDescriptor(key:"date", ascending: true)
        self.request.sortDescriptors = [sort]
        do{
            let AppointmentsDTO = try CoreDataManager.context.fetch(self.request)
            return AppointmentsDTO.map { Appointment(dto:$0)}
        }
        catch{
            return []
        }
    }
    
    static func delete(appointment: Appointment){
        CoreDataManager.context.delete(appointment.dto)
        CoreDataManager.save()
    }
}

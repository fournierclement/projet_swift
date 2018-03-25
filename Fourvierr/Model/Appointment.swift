//
//  Appointment.swift
//  Fourviere
//
//  Created by l on 25/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class Appointment {
    
    internal var dto : AppointmentDTO
    internal init(dto: AppointmentDTO){
        self.dto = dto
    }
    @discardableResult
    init(date: Date, doctor: Doctor) {
        if let dto = AppointmentDAO.search(date: date, doctor: doctor) {
            self.dto = dto
        } else {
            self.dto = AppointmentDAO.create(date: date, doctor: doctor)
        }
    }
    var date : Date {
        return self.dto.date! as Date
    }
    var doctor : Doctor {
        return Doctor(dto: self.dto.to_Meet!)
    }
    var day : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM"
        return formatter.string(from: self.date)
    }
    var hour : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: self.date)
    }
    var toString : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self.date) + " - " + self.doctor.toString
    }
}

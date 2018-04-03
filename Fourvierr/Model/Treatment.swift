//
//  Treatment.swift
//  Fourviere
//
//  Created by l on 01/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class Treatment {
    internal var dto : TreatmentDTO
    internal init(dto: TreatmentDTO){
        self.dto = dto
    }
    @discardableResult
    init(medecine: Medecine, quantity: String, endDate: Date, hours: [String]) {
        if let dto = TreatmentDAO.search(medecine: medecine, quantity: quantity) {
            self.dto = dto
            for hour in hours {
                dto.hours?.insert(hour)
            }
        } else {
            self.dto = TreatmentDAO.create(medecine: medecine, quantity: quantity, endDate: endDate, hours: hours)
        }
    }
    
    var medecine: String {
        return dto.takes!.name!
    }
    var quantity: String {
        return dto.quantity!
    }
    
    var hours: [String] {
        return self.dto.hours!.map { $0 }
    }
    
    var frequency: String {
        return "\(self.hours.count)/jour"
    }

    var getDailyDoses: [Dose]{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.dateFormat = "yyyy:MM:dd:"
        let todayString = dateFormatter.string(from: Date())
        dateFormatter.dateFormat = "yyyy:MM:dd:HH:mm"
        var doses: [Dose] = []
        var takeString: String
        var takeTime: Date
        for hour in self.hours {
            takeString = String(todayString + hour)
            takeTime = dateFormatter.date(from: takeString )!
            doses += [Dose(medecine: self.medecine, quantity: self.quantity, time: takeTime)]
        }
        return doses.sorted(by: { $0.time < $1.time })
    }
}

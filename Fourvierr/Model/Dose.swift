//
//  Dose.swift
//  Fourviere
//
//  Created by l on 01/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class Dose {
    // hh:mm
    static let dailyHours = ["6:00","7:00","8:00","9:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00"];
    
//    Might not need to be stored
//    internal var dto : DoseDTO
//    internal init(dto: DoseDTO){
//        self.dto = dto
//    }
    let time: Date
    let medecine: String
    let quantity: String
    
    init(medecine: String, quantity: String, time: Date) {
        self.time = time
        self.medecine = medecine
        self.quantity = quantity
    }
    var hour: String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self.time)
    }
}

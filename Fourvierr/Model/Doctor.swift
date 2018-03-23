//
//  Doctor.swift
//  Fourviere
//
//  Created by l on 20/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class Doctor {
    var lastname: String
    var doctorDAO: DoctorDAO
    
    var firstname: String?
    var city: String?
    var zipcode: Int?
    var street: String?
    // var type: enum
    
    init(lastname:String) {
        self.lastname = lastname
        self.doctorDAO = AbstractFactory.factory.getDoctorDAO()
    }
    
}

//
//  Doctor.swift
//  Fourviere
//
//  Created by l on 25/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class Doctor{
    
    internal var dto : DoctorDTO
    internal init(dto: DoctorDTO){
        self.dto = dto
    }
    @discardableResult
    init(lastName: String, speciality: Speciality, firstName: String?, phoneNumber: String?, address: String?) {
        if let dto = DoctorDAO.search(lastName: lastName, speciality: speciality) {
            self.dto = dto
        } else {
            self.dto = DoctorDAO.create(lastName: lastName, speciality: speciality, firstName: firstName, phoneNumber: phoneNumber, address: address)
        }
    }
    
    init(lastName: String, speciality: Speciality){
        if let dto = DoctorDAO.search(lastName: lastName, speciality: speciality) {
            self.dto = dto
        } else {
            self.dto = DoctorDAO.create(lastName: lastName, speciality: speciality, firstName: nil, phoneNumber: nil, address: nil)
        }
    }
    
    var lastName : String {
        return self.dto.lastName!
    }
    var firstName : String? {
        return self.dto.firstName
    }
    var phoneNumber : String? {
        return self.dto.phoneNumber
    }
    var address : String? {
        return self.dto.address
    }
    var speciality : String? {
        return self.dto.practices?.label
    }
    var toString : String {
        guard let speciality = self.speciality?.prefix(4) else {
            return self.lastName
        }
        return  speciality + ". " + self.lastName
    }
    
}

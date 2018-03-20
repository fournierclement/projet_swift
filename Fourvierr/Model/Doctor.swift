//
//  Doctor.swift
//  Fourviere
//
//  Created by l on 20/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class Doctor {
    var firstname: String
    var lastname: String
    var city: String
    var zipcode: Int
    var street: String
    
    init(firstname:String, lastname:String, city:String, zipcode: Int, street: String ) {
        self.firstname=firstname
        self.lastname=lastname
        self.city=city
        self.zipcode=zipcode
        self.street=street
    }
    var fullname: String {
        return self.firstname + " " + self.lastname;
    }
    
    var address: String {
        return self.street + "\n" + String(self.zipcode) + " " + self.city
    }
}

//
//  Speciality.swift
//  Fourviere
//
//  Created by l on 25/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class Speciality {
    internal let dto : SpecialityDTO
    internal init(dto: SpecialityDTO){
        self.dto = dto
    }
    @discardableResult
    init(label: String){
        if let dto = SpecialityDAO.search(label: label) {
            self.dto = dto
        } else {
            self.dto = SpecialityDAO.create(label: label)
        }
    }
    var label : String {
        return self.dto.label!
    }
}

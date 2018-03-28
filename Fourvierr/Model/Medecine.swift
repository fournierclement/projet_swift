//
//  Medecine.swift
//  Fourviere
//
//  Created by l on 25/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class Medecine {
    internal let dto : MedecineDTO
    internal init(dto: MedecineDTO){
        self.dto = dto
    }
    @discardableResult
    init(name: String, descriptus: String?){
        if let dto = MedecineDAO.search(name: name) {
            self.dto = dto
        } else {
            self.dto = MedecineDAO.create(name: name, descriptus: descriptus)
        }
    }
    var name : String {
        return self.dto.name!
    }
    var descriptus : String? {
        return self.dto.descriptus
    }
}


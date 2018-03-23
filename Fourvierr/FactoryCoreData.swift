//
//  FactoryCoreData.swift
//  Fourviere
//
//  Created by l on 20/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class FactoryCoreData: AbstractFactory {
    var doctorDAO: DoctorDAO
    init(){
        self.doctorDAO = DoctorCoreDataDAO()
    }
    override func getDoctorDAO() -> DoctorDAO {
        
    }
}

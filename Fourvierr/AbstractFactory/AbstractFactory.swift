//
//  AbstractFactory.swift
//  Fourviere
//
//  Created by l on 20/03/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation

class AbstractFactory {
    static let factory = AbstractFactory.buildFactory()
    static private func buildFactory() -> AbstractFactory {
        return FactoryCoreData()
    }
    
    func getDoctorDAO() -> DoctorDAO {
        preconditionFailure("This method must be overridden")
    }
}


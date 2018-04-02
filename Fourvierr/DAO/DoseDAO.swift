//
//  DoseDAO.swift
//  Fourviere
//
//  Created by l on 01/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
import CoreData

class DoseDAO {
//    static let request : NSFetchRequest<DoseDTO> = DoseDTO.fetchRequest()
    
    // MARK: - Dose Initialization
    
    static func initialize () {
    }
    
    static func getDailyDoses() -> [Dose] {
        let treatments: [Treatment] = TreatmentDAO.getAll()!
        let doses: [Dose] = treatments.flatMap { $0.getDailyDoses }
        return doses.sorted(by: { $0.time < $1.time })
    }
}

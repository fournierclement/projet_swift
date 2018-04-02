//
//  CoreDataManager.swift
//  TP07-CoreData
//
//  Created by Fiorio Christophe on 17/03/2018.
//  Copyright © 2018 Christophe Fiorio. All rights reserved.
//
//
/*
    Bonjour monsieur, vous remarquerez sans doute que ce fichier est exactement celui du TP07.
 Je devez vous demander quelle était la différence (vis à vis du plagia) entre le copier coller 'direct'
 comme celui ci, et copier la logique d'un morceau de code ?
 Je sais que je n'ai théoriquement pas le droit de prendre ce fichier sans autorisation pour un projet.
 Cependant est-ce que j'ai le droit d'en recopier la logique ?
 Ou dois-je appliquer la même idée globale d'une autre manière ?
 
 Ayant oublié de vous poser la question pendant les TP, je pose la question ici.
 Soyez tout de même assuré que j'ai (je pense) compris à quoi sert chaque ligne de ce fichier.
 
 Merci de votre compréhension,
 Respectieusement,
 Fournier Clément
*/

import Foundation

import UIKit
import CoreData

class CoreDataManager{
    /// context manager
    static let context : NSManagedObjectContext = {
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else {
            exit(EXIT_FAILURE)
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    /// return entity description from context
    ///
    /// - Parameter name: name of the entity
    /// - Returns: corresponding NSEntityDescription
    class func entity(forName name: String) -> NSEntityDescription{
        guard let entity=NSEntityDescription.entity(forEntityName: name, in: self.context) else{
            fatalError("get entity \(name) description failed")
        }
        return entity
    }
    
    @discardableResult
    /// save all data
    ///
    /// - Returns: NSError or nil if save successes
    class func save() -> NSError?{
        // try to save it
        do{
            try CoreDataManager.context.save()
            return nil
        }
        catch let error as NSError{
            return error
        }
    }
}

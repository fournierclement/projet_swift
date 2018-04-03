//
//  Pusher.swift
//  Fourviere
//
//  Created by l on 03/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//
//  Source tutorial https://useyourloaf.com/blog/local-notifications-with-ios-10/
//


import Foundation
import UserNotifications
import CoreData
import UIKit

class Pusher: NSObject, UNUserNotificationCenterDelegate {
    
    static let center = UNUserNotificationCenter.current()
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Play sound and show alert to the user
        completionHandler([.alert,.sound])
    }

    // MARK: - Actions
    
    // Prise Medocs
    static let TREATMENT = "treatmentNotif"
    static let DONE = "Confirme"
    
    static let doneAction = UNNotificationAction(identifier: Pusher.DONE, title: "Confirmer Prise", options:[])
    
    static let treatCategory = UNNotificationCategory(identifier: Pusher.TREATMENT, actions: [Pusher.doneAction],intentIdentifiers: [], options: [])
    
    // Dyskinesie
    static let DYSKINESIE = "Dyskinesie"
    static let FINE = "fine"
    
    static let dyskinesieAction = UNNotificationAction(identifier: Pusher.DYSKINESIE, title: "Dyskinesie", options:[])
    static let fineAction = UNNotificationAction(identifier: Pusher.FINE, title: "Ça va", options:[])
    
    static let dyskCategory = UNNotificationCategory(identifier: Pusher.DYSKINESIE, actions: [Pusher.dyskinesieAction, Pusher.fineAction],intentIdentifiers: [], options: [])
    
    // Rdv
    
    // Mark : Action handler
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("coucou...")
        switch response.notification.request.content.categoryIdentifier  {
            case UNNotificationDismissActionIdentifier:
                print("Dismiss Action")
            case UNNotificationDefaultActionIdentifier:
                print("Default")
            case Pusher.DONE:
                print("Done")
            case Pusher.DYSKINESIE:
                print("Dyskinesie")
            case Pusher.FINE:
                print("Fine")
            default:
                print("Unknown action")
        }
        completionHandler()
    }
    
    // MARK: - Other Functions
    
    static func push(request: UNNotificationRequest ){
        Pusher.center.add(request, withCompletionHandler: {
            (error) in
            if error != nil {
                print("oopsy")
            }
        })
    }
    
    static func delete(identifier: String) {
        Pusher.center.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}

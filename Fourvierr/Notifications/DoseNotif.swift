//
//  AppointmentNotif.swift
//  Fourviere
//
//  Created by l on 03/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
import UserNotifications

class DoseNotif: AbstractNotif {
    
    var trigger: UNCalendarNotificationTrigger
    var content: UNMutableNotificationContent
    var request: UNNotificationRequest?
    
    init(identifier: String, dose: Dose){
        
        // Trigger
        var dateNotif:Date
        if ( Date() > dose.time ) {
            dateNotif = Calendar.current.date(byAdding: .day, value: 1, to: dose.time)!
        } else {
            dateNotif = dose.time
        }
        var dateComponentNotif = Calendar.current.dateComponents(in: TimeZone.current, from: dateNotif)
        dateComponentNotif.quarter = nil
        
        self.trigger = UNCalendarNotificationTrigger(dateMatching: dateComponentNotif , repeats: true)
        
        // Content
        self.content = UNMutableNotificationContent()
        self.content.title = "Medicaments"
        self.content.body = "\(dose.quantity) \(dose.medecine)"
        self.content.categoryIdentifier = Pusher.TREATMENT
        self.content.sound = UNNotificationSound.default()
        
        super.init()
        self.id = identifier
        self.request = UNNotificationRequest(identifier: self.id!, content: self.content, trigger: self.trigger)
        
        // Push
        Pusher.push(request: self.request!)
    }
}


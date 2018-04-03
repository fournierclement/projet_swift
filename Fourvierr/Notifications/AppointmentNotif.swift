//
//  AppointmentNotif.swift
//  Fourviere
//
//  Created by l on 03/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
import UserNotifications

class AppointmentNotif: AbstractNotif {
    
    var trigger: UNCalendarNotificationTrigger
    var content: UNMutableNotificationContent
    var request: UNNotificationRequest?
    
    init(identifier: String, appointment: Appointment){
        
        // Trigger
        let dateNotif = Calendar.current.date(byAdding: .hour, value:-1, to: appointment.date)!
        var dateComponentNotif = Calendar.current.dateComponents(in: TimeZone.current, from: dateNotif)
        dateComponentNotif.quarter = nil
        self.trigger = UNCalendarNotificationTrigger(dateMatching: dateComponentNotif , repeats: false)
        
        // Content
        self.content = UNMutableNotificationContent()
        self.content.title = "Vous avez rendez-vous"
        self.content.body = "Vous avez rendez-vous dans 1heure avec \(appointment.doctor.toString)"
        self.content.sound = UNNotificationSound.default()
        
        super.init()
        self.id = identifier
        self.request = UNNotificationRequest(identifier: self.id!, content: self.content, trigger: self.trigger)
        
        // Push
        Pusher.push(request: self.request!)
        if (appointment.doctor.speciality == Speciality.neurologue) {
            DyskinesieNotif.startTest(endDate: appointment.date)
        }
    }
}

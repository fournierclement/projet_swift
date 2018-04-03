//
//  AppointmentNotif.swift
//  Fourviere
//
//  Created by l on 03/04/2018.
//  Copyright © 2018 polytechIG. All rights reserved.
//

import Foundation
import UserNotifications

class DyskinesieNotif: AbstractNotif {
    
    var trigger: UNCalendarNotificationTrigger
    var content: UNMutableNotificationContent
    var request: UNNotificationRequest?

    init(testTime: DateComponents){
        self.trigger = UNCalendarNotificationTrigger(dateMatching: testTime , repeats: true)
        
        // Content
        self.content = UNMutableNotificationContent()
        self.content.title = "Comment vous sentez vous ?"
        self.content.categoryIdentifier = Pusher.DYSKINESIE
        self.content.sound = UNNotificationSound.default()
        
        super.init()
        self.id = DyskinesieNotif.dateToId(dateComp: testTime)
        self.request = UNNotificationRequest(identifier: self.id!, content: self.content, trigger: self.trigger)
        
        // Push
        Pusher.push(request: self.request!)
    }
    
    private static func dateToId(dateComp: DateComponents) -> String {
        return "\(dateComp.month!)-\(dateComp.day!)-\(dateComp.hour!)"
    }
    
    
    
    static func startTest(endDate: Date) {
        var date:Date
        var dateComponentNotif: DateComponents
        for day in  Rapport.days {
            date = Calendar.current.date(byAdding: .day, value: day, to: endDate)!
            for hour in Rapport.hours {
                dateComponentNotif = Calendar.current.dateComponents(in: .current, from: date)
                dateComponentNotif.hour = hour
                dateComponentNotif.quarter = nil
                DyskinesieNotif(testTime: dateComponentNotif)
            }
        }
    }
}



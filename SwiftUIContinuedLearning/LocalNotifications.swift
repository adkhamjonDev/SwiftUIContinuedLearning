//
//  LocalNotifications.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 29/11/24.
//

import SwiftUI
import CoreLocation


class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current()
            .requestAuthorization(options: options) { (success, error) in
                if let error = error {
                    print("ERROR: \(error)")
                } else {
                    print("SUCCESS")
                }
            }
    }
    
    func schedulenotification() {
        let content = UNMutableNotificationContent()
        
        content.title = "This is my first notification"
        content.subtitle = "This is so easy!"
        content.sound = .default
        content.badge = 1
        
        // triggers
        // 1 time, 2 calendar, 3 location
        
        // time
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 49
        //dateComponents.weekday = 1 // monday
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        // location
        let coordinates = CLLocationCoordinate2D(latitude: 41.4564, longitude: 69.3454)
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString
        )
        region.notifyOnEntry = true
        region.notifyOnExit = true
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotifications: View {
    var body: some View {
        VStack {
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule Notification") {
                NotificationManager.instance.schedulenotification()
            }
            
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

#Preview {
    LocalNotifications()
}

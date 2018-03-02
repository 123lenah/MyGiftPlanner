//
//  addNotificationVC.swift
//  presentbase1
//
//  Created by Lenah Syed on 3/15/17.
//  Copyright © 2017 Lenah Syed. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class addNotificationVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    var prePerson: String!
    var prePresent: String!
    var preInfo: String!
    var preLocation: String!
    var prePicture: Data!
    
    var managedObjectContext: NSManagedObjectContext!
    
    @IBAction func addPresentWithReminder(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.managedObjectContext
        let date = datePicker.date
        let calendar = Calendar.current
        
      
        
       
        let unitFlags = Set<Calendar.Component>([.hour, .year, .minute, .day, .month])
        let components = calendar.dateComponents(unitFlags, from: date as Date)

        
                if #available(iOS 10.0, *) {
           let content = UNMutableNotificationContent()
            content.title = "Present due"
            content.body = "\(prePresent!) is due for \(prePerson!)!"
            content.categoryIdentifier = "present"
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: prePresent, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(
                request, withCompletionHandler: nil)
                    
                
            
        } else {
                let notification = UILocalNotification()
                notification.alertBody = "\(prePresent) is due for \(prePerson)!"
                notification.alertAction = "open"
                notification.fireDate = datePicker.date
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.category = "Present_category"
                notification.userInfo = ["UUID": "ilovenoodles"]
                UIApplication.shared.scheduleLocalNotification(notification)

   
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Present", in: managedObjectContext)
        let presentItem = Present(entity: entity!, insertInto: managedObjectContext)

        presentItem.person = prePerson
        presentItem.present = prePresent
        presentItem.info = preInfo
        presentItem.location = preLocation
        presentItem.date = datePicker.date
        presentItem.image = prePicture
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("could not save")
        }
       
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDate = Date()
        datePicker.minimumDate = currentDate
        
        datePicker.setValue(UIColor.white, forKey: "textColor")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

//
//  ChristmasPresentsTableViewController.swift
//  presentbase1
//
//  Created by Lenah Syed on 2/27/17.
//  Copyright © 2017 Lenah Syed. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class ChristmasPresentsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate {

    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    var presents = [Present]()
    
    
    
    // TEST TEST TEST ON ALL DEVICES AGAIN
    // push to app store :)
        // submit build to itunesconnect

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()

        let iconImageView = UIImageView(image: UIImage(named: "Gift-48"))
        self.navigationItem.titleView = iconImageView
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.managedObjectContext
        
        
               
        
       
    }
    
    
    func loadData() {
        let presentRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Present")
        do {
            
            let results = try managedObjectContext.fetch(presentRequest) as! [Present]
            presents = results // adds a new present
        } catch let error as NSError {
            print("Could not fetch presents \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presents.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PresentsTableViewCell
        cell.deleteButton.isHidden = true
        cell.deleteButton.isEnabled = false
        
        
    
        
        let presentItem = presents[indexPath.row]
        
         if presentItem.image != nil {
           let presentImage = UIImage(data: presentItem.image! as Data)
           cell.backgroundImage.image = presentImage
         } else {
            cell.backgroundImage.image = nil
        }
        
        cell.nameLabel.text = presentItem.person
        cell.itemLabel.text = presentItem.present
        

        cell.tag = indexPath.row
        
        
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let presentName = self.presents[indexPath.row].present
        switch editingStyle {
        case .delete:
            //remove the deleted item from the model
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
                    var identifiers: [String] = []
                    for notification: UNNotificationRequest in notificationRequests {
                        if notification.identifier == presentName {
                            identifiers.append(notification.identifier)
                        }
                    }
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
                }
            } else {
                // Fallback on earlier versions
            }
            
            managedObjectContext.delete(presents[indexPath.row])
            presents.remove(at: indexPath.row)
            do {
                try managedObjectContext.save()
            } catch {
                print("error")
            }
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            return
        }
        
    }
    
 
    
    @IBAction func addPresent(_ sender: AnyObject) {
      /*  let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)*/
    }
    
    
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picker.dismiss(animated: true, completion: {
                self.createPresentItem(with: image)
            })
        }
  
    }
    
    func createPresentItem(with image: UIImage) {
        let entity = NSEntityDescription.entity(forEntityName: "Present", in: managedObjectContext)
        let presentItem = Present(entity: entity!, insertInto: managedObjectContext)
        presentItem.image = NSData(data: UIImageJPEGRepresentation(image, 0.3)!) as Data as Data
        
        do {
            try self.managedObjectContext.save()
            self.loadData()
            self.tableView.reloadData()
        } catch {
            print("could not save data")
        }
             
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "segueAddVC") {
            let addVC = segue.destination as! AddVC
                addVC.managedObjectContext = managedObjectContext
            addVC.appDelegate1 = appDelegate
            
            
        }

        if (segue.identifier == "segue") {
            let detailVC = segue.destination as! DetailVC
            let cell = sender as! PresentsTableViewCell
            let indexPath = cell.tag
            detailVC.prePresentIndex = indexPath
            detailVC.prePresent = presents[indexPath]
            detailVC.managedObjectContext = managedObjectContext
            
        }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
   
        loadData()
        tableView.reloadData()
        

    }
    
    

}

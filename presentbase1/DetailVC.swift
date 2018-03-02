//
//  DetailVC.swift
//  presentbase1
//
//  Created by Lenah Syed on 3/8/17.
//  Copyright © 2017 Lenah Syed. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var personLabel: UILabel!
    var nameOfGiver: String!
    var nameOfPresent: String!
    var prePresent: Present!
    var managedObjectContext: NSManagedObjectContext!
    var prePresentIndex: Int!
    
    @IBOutlet weak var presentTextField: UITextField!
    
    @IBOutlet weak var personTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet var infoTextField: UITextView!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var presentLabel: UILabel!
    @IBOutlet weak var editInfoButton: UIButton!
    
    
    
    
    @IBAction func editInfo(_ sender: Any) {
        if editInfoButton.titleLabel?.text == "Edit Info" {
            editInfoButton.setTitle("Save", for: .normal)
            editInfoButton.setTitleColor(UIColor.green, for: .normal)
            infoTextField.isEditable = true
            locationTextField.isEnabled = true
            locationTextField.isHidden = false
            presentTextField.isEnabled = true
            presentTextField.isHidden = false
            personTextField.isHidden = false
            personTextField.isEnabled = true
            
        }
        
        if editInfoButton.titleLabel?.text == "Save" {
            editInfoButton.setTitle("Edit Info", for: .normal)
            editInfoButton.setTitleColor(UIColor.blue, for: .normal)
            infoTextField.isEditable = false
            locationTextField.isEnabled = false
            locationTextField.isHidden = true
            presentTextField.isEnabled = false
            presentTextField.isHidden = true
            personTextField.isHidden = true
            personTextField.isEnabled = false
            
            // get the index of the person
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            managedObjectContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Present")
            
            
            do {
            let records = try managedObjectContext.fetch(fetchRequest)
        
                if let records = records as? [NSManagedObject] {
                    var managedObject = records[prePresentIndex]
                    managedObject.setValue(locationTextField.text, forKey: "location")
                    managedObject.setValue(presentTextField.text, forKey: "present")
                    managedObject.setValue(infoTextField.text, forKey: "info")
                    managedObject.setValue(personTextField.text, forKey: "person")
                    
                    locationLabel.text = locationTextField.text
                    presentLabel.text = presentTextField.text
                    infoTextField.text = infoTextField.text
                    personLabel.text = personTextField.text
                    
                    self.title = personTextField.text
                    
                    do {
                      try managedObjectContext.save()
                    } catch {
                        print("could not save")
                    }
                }
            
            } catch {
                print("Error")
            }
            //NEED TO GET THE INDEX
            // THIS MIGHT HELP: http://stackoverflow.com/questions/26345189/how-do-you-update-a-coredata-entry-that-has-already-been-saved-in-swift 
   
        
       }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        editInfoButton.setTitleColor(UIColor.blue, for: .normal)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        presentTextField.delegate = self
        locationTextField.delegate = self
        personTextField.delegate = self
        
        personTextField.isHidden = true
        personTextField.isEnabled = false
        presentTextField.isHidden = true
        locationTextField.isHidden = true
        presentTextField.isEnabled = false
        locationTextField.isEnabled = false
        presentTextField.text = prePresent.present
        locationTextField.text = prePresent.location
        personTextField.text = prePresent.person
        
   

        self.title = prePresent.person
        
        presentLabel.text = prePresent.present
        locationLabel.text = prePresent.location
        infoTextField.text = prePresent.info
        personLabel.text = prePresent.person
      //  infoTextField.backgroundColor = UIColor.clearColor()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationTextField.resignFirstResponder()
        presentTextField.resignFirstResponder()
        personTextField.resignFirstResponder()
        
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

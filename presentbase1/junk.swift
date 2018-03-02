//
//  junk.swift
//  presentbase1
//
//  Created by Lenah Syed on 3/9/17.
//  Copyright © 2017 Lenah Syed. All rights reserved.
//

import Foundation
/*
//add gestures
//let doubleTap = UITapGestureRecognizer(target: self, action: "doubleTap:")
let buttonPressed = UILongPressGestureRecognizer(target: self, action: "longPressed:")

//add Function
cell.deleteButton.addTarget(self, action: "buttonDeletePressed:", forControlEvents: .TouchUpInside)

//doubleTap.numberOfTapsRequired = 2
//doubleTap.numberOfTouchesRequired = 1
// buttonPressed.minimumPressDuration = 2
//cell.addGestureRecognizer(buttonPressed)*/


/*func longPressed(sender: UILongPressGestureRecognizer) {

let indexPath = NSIndexPath(forRow: sender.view!.tag, inSection: 0)
if let cell = tableView.cellForRowAtIndexPath(indexPath) as? PresentsTableViewCell {
cell.deleteButton.backgroundColor = UIColor.redColor()

if cell.deleteButton.hidden == false && cell.deleteButton.enabled == true {
cell.deleteButton.hidden = true
cell.deleteButton.enabled = false

} else {
cell.deleteButton.hidden = false
cell.deleteButton.enabled = true
}

}



}
func buttonDeletePressed(sender:UIButton) {
let index = sender.tag

managedObjectContext.deleteObject(presents[index] as NSManagedObject)
presents.removeAtIndex(index)

let error: NSError! = nil
do {
try managedObjectContext.save()
self.tableView.reloadData()
} catch {
print("error: \(error)")
}
}
 
 /*
 let inputAlert = UIAlertController(title: "New Present", message: "Enter a person and a present", preferredStyle: .Alert)
 inputAlert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
 textField.placeholder = "Person"
 }
 inputAlert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
 textField.placeholder = "Present"
 }
 
 inputAlert.addAction(UIAlertAction(title: "Save", style: .Default, handler: { (UIAlertAction) -> Void in
 let personTextField = inputAlert.textFields?.first
 let presentTextField = inputAlert.textFields?.last
 
 if personTextField?.text != "" && presentTextField?.text != "" {
 presentItem.person = personTextField?.text
 presentItem.present = presentTextField?.text
 
 do {
 try self.managedObjectContext.save()
 self.loadData()
 self.tableView.reloadData()
 } catch {
 print("Could not save data")
 }
 }
 }))
 
 inputAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
 self.presentViewController(inputAlert, animated: true, completion: nil)*/
 


*/


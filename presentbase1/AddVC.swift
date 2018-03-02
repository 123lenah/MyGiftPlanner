//
//  AddVC.swift
//  presentbase1
//
//  Created by Lenah Syed on 3/12/17.
//  Copyright © 2017 Lenah Syed. All rights reserved.
//

import UIKit
import CoreData

class AddVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextView!
    @IBOutlet weak var presentTextField: UITextField!
    @IBOutlet weak var personTextField: UITextField!
    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var presentItem: Present!
    var prePicture: Data!
    var entity: NSEntityDescription!
    var appDelegate1: AppDelegate!
    
    var activeField: UITextField?

    /*
    func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        
        let adjustmentHeight = ((keyboardFrame.height) + 20) * (show ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
        func keyboardWillShow(notification: NSNotification) {
            
            adjustInsetForKeyboardShow(show: true, notification: notification)
            scrollView.isScrollEnabled = true
            
        }
        
        
        func keyboardWillHide(notification: NSNotification) {
            adjustInsetForKeyboardShow(show: false, notification: notification)
            scrollView.isScrollEnabled = false
        }*/

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        if textField == locationTextField {
            scrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.locationTextField.delegate = self
       self.presentTextField.delegate = self
       self.personTextField.delegate = self
        
        self.locationTextField.returnKeyType = UIReturnKeyType.done
        personTextField.returnKeyType = .done
        presentTextField.returnKeyType = .done
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
       // NotificationCenter.default.addObserver(self, selector: #selector(AddVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
       // NotificationCenter.default.addObserver(self, selector: #selector(AddVC.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    

    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        presentTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        personTextField.resignFirstResponder()
        return true
    }
    
    

  
    
    
    @IBAction func addPresentButton(_ sender: AnyObject) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.managedObjectContext

        
        if (personTextField.text == "" || infoTextField.text == "" || presentTextField.text == "" || locationTextField.text == "" || prePicture == nil) {
            let alert = UIAlertController(title: "Empty Spaces", message: "You need to fill all the spaces required", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Return", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            entity = NSEntityDescription.entity(forEntityName: "Present", in: managedObjectContext)
            presentItem = Present(entity: entity!, insertInto: managedObjectContext) // this is the problemo
            presentItem.person = personTextField.text
            presentItem.present = presentTextField.text
            presentItem.info = infoTextField.text
            presentItem.location = locationTextField.text
            presentItem.image = prePicture
            
            do {
                try self.managedObjectContext.save()
                
            } catch {
                print("Could not save data")
            }
            
            
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        

       
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            
            prePicture = NSData(data: UIImageJPEGRepresentation(image, 0.3)!) as Data
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pictureButton(_ sender: AnyObject) {
        presentImagePicker()

    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if (segue.identifier == "segueDate") {
            if (personTextField.text == "" || infoTextField.text == "" || presentTextField.text == "" || locationTextField.text == "" || prePicture == nil) {
                let alert = UIAlertController(title: "Empty Spaces", message: "You didn't complete all the spaces", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Return", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
             
                

                let dateVC = segue.destination as! addNotificationVC
                let person = personTextField.text
                let present = presentTextField.text
                let info = infoTextField.text
                let location = locationTextField.text
                dateVC.prePresent = present
                dateVC.prePerson = person
                dateVC.preLocation = location
                dateVC.preInfo = info
                dateVC.prePicture = prePicture
            }
  
        }
    }
}

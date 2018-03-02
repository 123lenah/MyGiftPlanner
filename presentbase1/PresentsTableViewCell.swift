//
//  PresentsTableViewCell.swift
//  presentbase1
//
//  Created by Lenah Syed on 2/27/17.
//  Copyright © 2017 Lenah Syed. All rights reserved.
//

import UIKit
import CoreData

class PresentsTableViewCell: UITableViewCell {
    var selectionCallBack: (() -> Void)?
    
    var managedObjectContext: NSManagedObjectContext!
    var presents = [Present]()

    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func deleteButtonAction(_ sender: AnyObject) {
        print("the delete button has been pressed")
        
    }
    
    /*override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addSubview(self.deleteButton)
    }*/
    
  
    

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        superview?.bringSubview(toFront: view)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

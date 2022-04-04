//
//  ContactsCell.swift
//  RealmTodoList
//
//  Created by Neosoft on 03/04/22.
//

import UIKit

class ContactsCell: UITableViewCell {

    
    @IBOutlet weak var contactNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

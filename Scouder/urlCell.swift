//
//  urlCell.swift
//  Scouder
//
//  Created by Vasisht Muduganti on 07/12/19.
//  Copyright © 2019 Vasisht Muduganti. All rights reserved.
//

import UIKit

class urlCell: UITableViewCell, UITextFieldDelegate {

    
    @IBOutlet weak var urlField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        urlField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        //textField code

        urlField.resignFirstResponder()  //if desired
    
        return true
    }
}

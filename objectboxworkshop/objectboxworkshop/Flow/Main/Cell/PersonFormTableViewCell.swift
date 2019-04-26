//
//  PersonFormTableViewCell.swift
//  objectboxworkshop
//
//  Created by Lucas Torres Mezzari on 25/04/19.
//  Copyright © 2019 Lucas Torres Mezzari. All rights reserved.
//

import UIKit

protocol PersonFormTableViewCellDelegate {
    func didPressSave(_ name: String, _ age: Int)
}

class PersonFormTableViewCell: UITableViewCell {
    
    @IBOutlet weak var formTitleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var delegate: PersonFormTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func didPressSave(_ sender: Any) {
        guard
            let name = nameTextField.text,
            let age = Int(ageTextField.text ?? "0")
        else {
            return
        }
        
        formTitleLabel.text = "Add Person"
        nameTextField.text = ""
        ageTextField.text = ""
        delegate?.didPressSave(name, age)
    }
}

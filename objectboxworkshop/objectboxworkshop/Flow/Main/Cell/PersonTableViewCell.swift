//
//  PersonTableViewCell.swift
//  objectboxworkshop
//
//  Created by Lucas Torres Mezzari on 25/04/19.
//  Copyright © 2019 Lucas Torres Mezzari. All rights reserved.
//

import UIKit

protocol PersonTableViewCellDelegate {
    func didPressCell(_ person: Person)
}

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    
    var delegate: PersonTableViewCellDelegate?
    
    var person: Person! {
        didSet {
            nameLabel.text = person.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func didPressCell(_ sender: Any) {
        delegate?.didPressCell(person)
    }
}

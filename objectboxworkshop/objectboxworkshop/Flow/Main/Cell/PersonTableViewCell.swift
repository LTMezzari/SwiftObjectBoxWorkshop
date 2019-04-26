//
//  PersonTableViewCell.swift
//  objectboxworkshop
//
//  Created by Lucas Torres Mezzari on 25/04/19.
//  Copyright © 2019 Lucas Torres Mezzari. All rights reserved.
//

import UIKit

protocol PersonTableViewCellDelegate {
    func didPressCell(_ cell: PersonTableViewCell, _ person: Person)
    
    func didLongPressCell()
}

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton! {
        didSet {
            cellButton.addGestureRecognizer (UILongPressGestureRecognizer(target: self, action: #selector(didLongPressCell(gesture:))))
        }
    }
    @IBOutlet weak var checkView: UICheckView! {
        didSet {
            checkView.isEnabled = false
            checkView.isChecked = true
        }
    }
    
    var delegate: PersonTableViewCellDelegate?
    
    var person: Person! {
        didSet {
            nameLabel.text = person.name
            checkView.isChecked = person.isSelected
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func didPressCell(_ sender: Any) {
        delegate?.didPressCell(self, person)
    }
    
    @objc func didLongPressCell(gesture: UILongPressGestureRecognizer) {
        delegate?.didLongPressCell()
    }
}

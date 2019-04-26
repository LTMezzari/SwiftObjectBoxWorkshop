//
//  FilterViewController.swift
//  objectboxworkshop
//
//  Created by Lucas Torres Mezzari on 25/04/19.
//  Copyright © 2019 Lucas Torres Mezzari. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func onItemsFiltered(_ persons: [Person])
}

class FilterViewController: UIViewController {
    
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var periodStartTextField: UITextField!
    @IBOutlet weak var periodEndTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    lazy var viewModel: FilterControllerViewModel = FilterControllerViewModel()
    
    var delegate: FilterViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didPressSearch(_ sender: Any) {
        let identifier = identifierTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let age = Int(ageTextField.text ?? "0") ?? 0
        let startPeriod = Int(periodStartTextField.text ?? "0") ?? 0
        let endPeriod = Int(periodEndTextField.text ?? "0") ?? 0
        
        viewModel.filter(identifier, name, age, startPeriod, endPeriod) { (persons) in
            self.delegate?.onItemsFiltered(persons)
            navigationController?.popViewController(animated: true)
        }
    }
}

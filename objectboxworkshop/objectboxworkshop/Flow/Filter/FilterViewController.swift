//
//  FilterViewController.swift
//  objectboxworkshop
//
//  Created by Lucas Torres Mezzari on 25/04/19.
//  Copyright © 2019 Lucas Torres Mezzari. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var periodStartTextField: UITextField!
    @IBOutlet weak var periodEndTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    let viewModel: FilterControllerViewModel = FilterControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didPressSearch(_ sender: Any) {
    }
}

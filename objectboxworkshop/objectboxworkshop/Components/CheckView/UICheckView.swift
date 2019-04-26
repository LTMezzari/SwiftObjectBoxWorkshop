//
//  CheckView.swift
//  objectboxworkshop
//
//  Created by Lucas Torres Mezzari on 26/04/19.
//  Copyright © 2019 Lucas Torres Mezzari. All rights reserved.
//

import UIKit

protocol UICheckViewDelegate {
    func onCheckedChange(_ sender: UICheckView, _ isChecked: Bool)
}

class UICheckView: UIView {
    
    @IBOutlet var contentView: UICheckView!
    @IBOutlet weak var checkViewButton: UIButton!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("UICheckView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    var uncheckedImage: UIImage? = UIImage(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), size: CGSize(width: 10, height: 10)) {
        didSet {
            handleCheck()
        }
    }
    
    var checkedImage: UIImage? = UIImage(color: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), size: CGSize(width: 10, height: 10)) {
        didSet {
            handleCheck()
        }
    }
    
    var isChecked: Bool = true {
        didSet {
            handleCheck()
        }
    }
    
    var isEnabled: Bool = true
    
    var delegate: UICheckViewDelegate?
    
    private func handleCheck() {
        if isChecked {
            checkImageView.image = checkedImage
        } else {
            checkImageView.image = uncheckedImage
        }
    }
    
    @IBAction func didPressCheckView(_ sender: Any) {
        if !isEnabled {
            return
        }
        
        isChecked = !isChecked
        delegate?.onCheckedChange(self, isChecked)
    }
}

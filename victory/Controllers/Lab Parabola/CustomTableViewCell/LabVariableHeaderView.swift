//
//  LabVariableHeaderView.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class LabVariableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var btnHeader: UIButton!
    
    var delegate: VariableHeaderDelegate?
    
    @IBAction func btnPressed(_ sender: UIButton) {
        delegate?.actionForButton(button: sender)
    }
}

protocol VariableHeaderDelegate: AnyObject {
    func actionForButton(button selectedButton: UIButton)
}

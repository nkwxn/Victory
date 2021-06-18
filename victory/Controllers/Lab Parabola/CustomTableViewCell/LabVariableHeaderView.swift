// swiftlint:disable trailing_whitespace
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
    
    weak var delegate: VariableHeaderDelegate?
    
    @IBAction func btnPressed(_ sender: UIButton) {
        delegate?.actionForButton()
    }
}

protocol VariableHeaderDelegate: AnyObject {
    func actionForButton()
}

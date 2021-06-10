//
//  rowLKSBodyCell.swift
//  victory
//
//  Created by Nicholas on 10/06/21.
//

import UIKit

class rowLKSBodyCell: UITableViewCell {
    @IBOutlet weak var lblUnitOfTest: UILabel!
    @IBOutlet weak var tfXmax: UITextField!
    @IBOutlet weak var tfYmax: UITextField!
    @IBOutlet weak var tfWaktuYMax: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tfEndEdit(_ sender: UITextField) {
        
    }
}

extension rowLKSBodyCell: UITextFieldDelegate {
    
}

protocol rowLKSBodyDelegate {
    func checkValue()
}

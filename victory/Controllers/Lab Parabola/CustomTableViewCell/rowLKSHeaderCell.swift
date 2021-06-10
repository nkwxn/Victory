//
//  rowLKSHeaderCell.swift
//  victory
//
//  Created by Nicholas on 10/06/21.
//

import UIKit

class rowLKSHeaderCell: UITableViewCell {
    @IBOutlet weak var variabelLKS: UILabel!
    @IBOutlet weak var satuanVariabelLKS: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var varLKS: SliderVariable? {
        didSet {
            satuanVariabelLKS.text = "[\(varLKS?.getUnit() ?? "[m/s]")]"
        }
    }
    
}

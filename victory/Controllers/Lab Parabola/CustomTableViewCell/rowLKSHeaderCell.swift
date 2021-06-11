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
            guard let unit = varLKS?.getUnit(),
                  let acronym = varLKS?.getAcronym()
            else { return }
            satuanVariabelLKS.text = "[\(unit)]"
            variabelLKS.text = acronym
        }
    }
    
}

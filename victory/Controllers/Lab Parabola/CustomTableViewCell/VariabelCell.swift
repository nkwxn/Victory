//
//  VariabelCell.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class VariabelCell: UITableViewCell {
    @IBOutlet weak var lblVarName: UILabel!
    @IBOutlet weak var imgVariable: UIImageView!
    @IBOutlet weak var lblVarAmount: UILabel!
    @IBOutlet weak var varSlider: UISlider!
    
    // Kasih variabel dan delegate untuk initialize yang lainnya
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

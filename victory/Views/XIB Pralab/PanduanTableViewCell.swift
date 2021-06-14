//
//  TableViewCell.swift
//  victory
//
//  Created by Wuri Dita on 10/06/21.
//

import UIKit

class PanduanTableViewCell: UITableViewCell {
    @IBOutlet weak var panduanImageView: UIImageView!
    @IBOutlet weak var panduanLbl: UILabel!
    /*
    // Setup View
    */
    func setView(index: Int) {
        panduanLbl.text = Constants.panduanLabs[0].langkah[index]
        switch index {
        case 0:
            panduanImageView.image = UIImage(systemName: "person.crop.circle.badge.checkmark")
        default:
            panduanImageView.image = UIImage(systemName: "\(index).circle")
        }
    }
}

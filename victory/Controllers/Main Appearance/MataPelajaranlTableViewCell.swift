//
//  MatkulTableViewCell.swift
//  testing
//
//  Created by Wuri Dita on 11/06/21.
//

import UIKit

class MataPelajaranTableViewCell: UITableViewCell {
    @IBOutlet weak var matpelImageView: UIImageView!
    @IBOutlet weak var matpelLbl: UILabel!
    @IBOutlet weak var cardBg: RoundCornersUIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

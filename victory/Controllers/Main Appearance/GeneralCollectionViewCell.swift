//
//  GeneralCollectionViewCell.swift
//  victory
//
//  Created by Daniella Stefani on 09/06/21.
//

import UIKit

class GeneralCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var generalCollectionView: RoundCornersUIView!
    @IBOutlet weak var generalCollectionImageView: UIImageView!
    @IBOutlet weak var generalCollectionTitleLabel: UILabel!
    @IBOutlet weak var generalCollectionSubtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

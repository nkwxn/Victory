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
    @IBOutlet var heightConstraintsSubtitleLabel: NSLayoutConstraint!
    @IBOutlet var heightConstraintTitleLabel: NSLayoutConstraint!
    @IBOutlet var heightConstraintImageView: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        generalCollectionView.shadowOffset = CGSize(width: 0,height: 4)
        generalCollectionView.shadowColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        generalCollectionView.shadowRadius = 10.0
    }

}

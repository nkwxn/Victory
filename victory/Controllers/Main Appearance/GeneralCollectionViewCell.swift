// swiftlint:disable trailing_whitespace
//
//  GeneralCollectionViewCell.swift
//  victory
//
//  Created by Daniella Stefani on 09/06/21.
//

import UIKit

class GeneralCollectionViewCell: UICollectionViewCell {
    static let identifier = "GeneralCollectionViewCell"
    
    @IBOutlet weak var generalCollectionView: UIView!
    @IBOutlet weak var generalCollectionImageView: UIImageView!
    @IBOutlet weak var generalCollectionTitleLabel: UILabel!
    @IBOutlet weak var generalCollectionSubtitleLabel: UILabel!
}

// swiftlint:disable trailing_whitespace
// swiftlint:disable line_length
//
//  MateriTableViewCell.swift
//  victory
//
//  Created by Wuri Dita on 18/06/21.
//

import UIKit

class MateriTableViewCell: UITableViewCell {
    static let identifier = "MateriTableViewCell"
    var didSelectItemAction: ((IndexPath) -> Void)?

    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedGradePraktikum: [Praktikum]? {
        didSet {
            setupCollectionView()
        }
    }
}

extension MateriTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView?.register(UINib(nibName: GeneralCollectionViewCell.identifier, bundle: nil),
                                 forCellWithReuseIdentifier: GeneralCollectionViewCell.identifier)
        
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selectedGradePraktikum?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralCollectionViewCell.identifier, for: indexPath) as? GeneralCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.generalCollectionImageView.image = selectedGradePraktikum?[indexPath.row].gambar
        cell.generalCollectionTitleLabel.text = selectedGradePraktikum?[indexPath.row].nama
        cell.generalCollectionSubtitleLabel.text = "Materi: \(String(describing: selectedGradePraktikum![indexPath.row].subtitleMateri))"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath)
    }
}

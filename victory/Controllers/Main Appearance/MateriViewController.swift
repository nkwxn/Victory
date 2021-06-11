//
//  MateriViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class MateriViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var materiCollectionView: UICollectionView!
    
    var praktikum = Constants.arrayOfPraktikum
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        materiCollectionView.dataSource = self

        let nib = UINib(nibName: "\(GeneralCollectionViewCell.self)", bundle: nil)
        self.materiCollectionView.register(nib, forCellWithReuseIdentifier: "generalCollectionCell")
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return praktikum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "generalCollectionCell", for: indexPath) as! GeneralCollectionViewCell
        
        cell.generalCollectionImageView.image = praktikum[indexPath.row].gambar
        cell.generalCollectionTitleLabel.text = praktikum[indexPath.row].nama
        cell.generalCollectionSubtitleLabel.text = praktikum[indexPath.row].subtitleMateri
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

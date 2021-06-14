//
//  MediaViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class MediaViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    
    var mediaPraktikum = Constants.arrayOfMediaPraktikum

    override func viewDidLoad() {
        super.viewDidLoad()

        mediaCollectionView.dataSource = self
        
        let nib = UINib(nibName: "\(GeneralCollectionViewCell.self)", bundle: nil)
        self.mediaCollectionView.register(nib, forCellWithReuseIdentifier: "generalCollectionCell")
        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaPraktikum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "generalCollectionCell", for: indexPath) as! GeneralCollectionViewCell
        
        cell.generalCollectionView.shadowOffset = CGSize(width: 0,height: 4)
        cell.generalCollectionView.shadowColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        cell.generalCollectionView.shadowRadius = 10.0
        cell.generalCollectionImageView.image = mediaPraktikum[indexPath.row].gambarMedia
        cell.generalCollectionTitleLabel.text = mediaPraktikum[indexPath.row].namaMedia
        cell.generalCollectionSubtitleLabel.text = ""
        
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

//
//  MediaViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

protocol MediaViewControllerDelegate {
    func moveToTanpaPanduan()
    func moveToDenganPanduan()
}

class MediaViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, MediaViewControllerDelegate {
    
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    @IBOutlet var superview: UIView!
    
    var mediaPraktikum = Constants.arrayOfMediaPraktikum
    let customAlert = MyAlert()
    var selectedPraktikum: Praktikum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mediaCollectionView.dataSource = self
        mediaCollectionView.delegate = self
        customAlert.delegate = self
        
        let nib = UINib(nibName: "\(GeneralCollectionViewCell.self)", bundle: nil)
        self.mediaCollectionView.register(nib, forCellWithReuseIdentifier: "generalCollectionCell")
        
        self.title = selectedPraktikum?.nama
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaPraktikum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "generalCollectionCell", for: indexPath) as! GeneralCollectionViewCell
        
        cell.generalCollectionImageView.image = mediaPraktikum[indexPath.row].gambarMedia
        cell.generalCollectionTitleLabel.text = mediaPraktikum[indexPath.row].namaMedia
        cell.generalCollectionTitleLabel.textAlignment = .center
        cell.generalCollectionSubtitleLabel.text = ""
        cell.heightConstraintsSubtitleLabel.constant = 0
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            let alert = UIAlertController(title: "Dalam Pengembangan", message: "Fitur ini sedang dikembangkan. Silahkan nantikan!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                @unknown default:
                    fatalError()
                }
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            customAlert.showAlert(with: "Pilih Jenis Praktikum", message: "Bakal diisi collection view", on: self)
        }
    }
    
    @objc func dismissAlert() {
        customAlert.dismissAlert()
    }
    
    func moveToTanpaPanduan() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "PraktikumTanpaPanduan", bundle: nil)
        let destVC = storyBoard.instantiateViewController(withIdentifier: "PraktikumTanpaPanduanScene") as! PraktikumTanpaPanduanViewController
        destVC.praktikum = self.selectedPraktikum
        
        self.navigationController?.pushViewController(destVC, animated: true)
        print ("move to tanpa panduan")
    }
    
    func moveToDenganPanduan() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "PraktikumBerpanduan", bundle: nil)
        let destVC = storyBoard.instantiateViewController(withIdentifier: "PraktikumBerpanduanScene") as! PraktikumBerpanduanViewController
        destVC.praktikum = self.selectedPraktikum
        
        self.navigationController?.pushViewController(destVC, animated: true)
        print ("move to dengan panduan")
    }
}

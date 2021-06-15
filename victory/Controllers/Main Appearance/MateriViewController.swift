//
//  MateriViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class MateriViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var materiCollectionView: UICollectionView!
    @IBOutlet weak var materiTitleNavigationItem: UINavigationItem!
    
    var praktikum = Constants.arrayOfPraktikum
    var filteredPraktikum: [Praktikum] = []
    var showAll = true
    
    var emptyStateImage = UIImage(systemName: "car")
    var emptyStateTitle = "Belum ada materi"
    var emptyStateSubtitle = "Nantikan materinya"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNotified(_:)), name: NSNotification.Name("menuupdate"), object: nil)
        
        materiCollectionView.dataSource = self
        materiCollectionView.delegate = self

        let nib = UINib(nibName: "\(GeneralCollectionViewCell.self)", bundle: nil)
        self.materiCollectionView.register(nib, forCellWithReuseIdentifier: "generalCollectionCell")
        // Do any additional setup after loading the view.
    }
<<<<<<< HEAD
    
    @objc func getNotified(_ object: Notification) {
        filteredPraktikum = []
        if let menu = object.userInfo?["indexpath"] as? Int {
            print(menu)
            switch menu {
            case 0:
                showAll = true
                materiTitleNavigationItem.title = "Semua Praktikum"
                materiCollectionView.reloadData()
            case 1:
                filterMateri(mapel: .fisika)
            case 2:
                filterMateri(mapel: .kimia)
            case 3:
                filterMateri(mapel: .biologi)
            case 4:
                filterMateri(mapel: .matematika)
            default:
                print("default")
            }
        }
    }
    
    func filterMateri(mapel: Mapel) {
        showAll = false
        materiTitleNavigationItem.title = mapel.rawValue
        for (index,materi) in praktikum.enumerated() {
            //HASHMAP
            if praktikum[index].mataPelajaran == mapel {
                filteredPraktikum.append(materi)
            }
            materiCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showAll && filteredPraktikum.isEmpty {
            return praktikum.count
        } else if filteredPraktikum.isEmpty {
            return 1
        } else {
            return filteredPraktikum.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "generalCollectionCell", for: indexPath) as! GeneralCollectionViewCell
        
        if showAll && filteredPraktikum.isEmpty {
            cell.generalCollectionImageView.image = praktikum[indexPath.row].gambar
            cell.generalCollectionTitleLabel.text = praktikum[indexPath.row].nama
            cell.generalCollectionSubtitleLabel.text = praktikum[indexPath.row].subtitleMateri
        } else if filteredPraktikum.isEmpty {
            cell.generalCollectionImageView.image = emptyStateImage
            cell.generalCollectionTitleLabel.text = emptyStateTitle
            cell.generalCollectionSubtitleLabel.text = emptyStateSubtitle
        } else {
            cell.generalCollectionImageView.image = filteredPraktikum[indexPath.row].gambar
            cell.generalCollectionTitleLabel.text = filteredPraktikum[indexPath.row].nama
            cell.generalCollectionSubtitleLabel.text = filteredPraktikum[indexPath.row].subtitleMateri
        }
        
        return cell
    }
    
=======
    /*
>>>>>>> main
    // MARK: - Navigation
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !filteredPraktikum.isEmpty || showAll {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let destVC = storyBoard.instantiateViewController(withIdentifier: "MediaViewControllerScene") as! MediaViewController
            destVC.selectedPraktikum = self.praktikum[indexPath.row]
            
            self.navigationController?.pushViewController(destVC, animated: true)
            self.splitViewController?.hide(UISplitViewController.Column.primary)
        }
    }
    
    
    
   

}

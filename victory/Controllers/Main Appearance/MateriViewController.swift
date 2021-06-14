//
//  MateriViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class MateriViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var materiCollectionView: UICollectionView!
    @IBOutlet weak var materiTitleNavigationItem: UINavigationItem!
    
    var praktikum = Constants.arrayOfPraktikum
    var selectedPraktikum: [Praktikum] = []
    var showAll = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNotified(_:)), name: NSNotification.Name("menuupdate"), object: nil)
        
        materiCollectionView.dataSource = self

        let nib = UINib(nibName: "\(GeneralCollectionViewCell.self)", bundle: nil)
        self.materiCollectionView.register(nib, forCellWithReuseIdentifier: "generalCollectionCell")
        // Do any additional setup after loading the view.
    }
    
    @objc func getNotified(_ object: Notification) {
        selectedPraktikum = []
        showAll = false
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
    
    func filterMateri(mapel: Mapel){
        showAll = false
        materiTitleNavigationItem.title = mapel.rawValue
        for (index,materi) in praktikum.enumerated(){
            if praktikum[index].mataPelajaran == mapel{
                _ = IndexPath(row: index, section: 0)
                selectedPraktikum.append(materi)
                materiCollectionView.reloadData()
            }else{
                materiCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showAll && selectedPraktikum.isEmpty{
            return praktikum.count
        } else if selectedPraktikum.isEmpty{
            return 1
        } else {
            return selectedPraktikum.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "generalCollectionCell", for: indexPath) as! GeneralCollectionViewCell
        if showAll && selectedPraktikum.isEmpty{
            cell.generalCollectionView.shadowOffset = CGSize(width: 0,height: 4)
            cell.generalCollectionView.shadowColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            cell.generalCollectionView.shadowRadius = 10.0
            cell.generalCollectionImageView.image = praktikum[indexPath.row].gambar
            cell.generalCollectionTitleLabel.text = praktikum[indexPath.row].nama
            cell.generalCollectionSubtitleLabel.text = praktikum[indexPath.row].subtitleMateri
        } else if selectedPraktikum.isEmpty{
            cell.generalCollectionView.shadowOffset = CGSize(width: 0,height: 4)
            cell.generalCollectionView.shadowColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            cell.generalCollectionView.shadowRadius = 10.0
            cell.generalCollectionImageView.image = UIImage(systemName: "car")
            cell.generalCollectionTitleLabel.text = "Belum ada Materi"
            cell.generalCollectionSubtitleLabel.text = "Tunggu untuk itu"
        } else{
            cell.generalCollectionView.shadowOffset = CGSize(width: 0,height: 4)
            cell.generalCollectionView.shadowColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            cell.generalCollectionView.shadowRadius = 10.0
            cell.generalCollectionImageView.image = selectedPraktikum[indexPath.row].gambar
            cell.generalCollectionTitleLabel.text = selectedPraktikum[indexPath.row].nama
            cell.generalCollectionSubtitleLabel.text = selectedPraktikum[indexPath.row].subtitleMateri
        }
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

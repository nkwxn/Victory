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
        if let menu = object.userInfo?["indexpath"] as? Int {
            print(menu)
            switch menu {
            case 0:
                materiTitleNavigationItem.title = "Fisika"
                for (index,materi) in praktikum.enumerated(){
                    if praktikum[index].mataPelajaran == .fisika{
                        print(materi.nama)
                        let indexPath = IndexPath(row: index, section: 0)
                        print ([indexPath])
                        selectedPraktikum.append(materi)
                        materiCollectionView.reloadData()
                    }
                }
            case 1:
                materiTitleNavigationItem.title = "Kimia"
                for (index,materi) in praktikum.enumerated(){
                    if praktikum[index].mataPelajaran == .kimia{
                        print(materi.nama)
                        let indexPath = IndexPath(row: index, section: 0)
                        print ([indexPath])
                        selectedPraktikum.append(materi)
                        materiCollectionView.reloadData()
                    }
                }
            case 2:
                materiTitleNavigationItem.title = "Biologi"
                for (index,materi) in praktikum.enumerated(){
                    if praktikum[index].mataPelajaran == .biologi{
                        print(materi.nama)
                        let indexPath = IndexPath(row: index, section: 0)
                        print ([indexPath])
                        selectedPraktikum.append(materi)
                        materiCollectionView.reloadData()
                    }
                }
            case 3:
                materiTitleNavigationItem.title = "Matematika"
                for (index,materi) in praktikum.enumerated(){
                    if praktikum[index].mataPelajaran == .matematika{
                        print(materi.nama)
                        let indexPath = IndexPath(row: index, section: 0)
                        print ([indexPath])
                        selectedPraktikum.append(materi)
                        materiCollectionView.reloadData()
                    }
                }
            default:
                print("default")
            }
        }
 //       materiCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedPraktikum.isEmpty{
            return praktikum.count
        } else {
            return selectedPraktikum.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "generalCollectionCell", for: indexPath) as! GeneralCollectionViewCell
        
        if selectedPraktikum.isEmpty{
            cell.generalCollectionView.shadowOffset = CGSize(width: 0,height: 4)
            cell.generalCollectionView.shadowColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            cell.generalCollectionView.shadowRadius = 10.0
            cell.generalCollectionImageView.image = praktikum[indexPath.row].gambar
            cell.generalCollectionTitleLabel.text = praktikum[indexPath.row].nama
            cell.generalCollectionSubtitleLabel.text = praktikum[indexPath.row].subtitleMateri
        }else{
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

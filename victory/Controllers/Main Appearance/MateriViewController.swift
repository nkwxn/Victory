// swiftlint:disable trailing_whitespace
// swiftlint:disable cyclomatic_complexity
//
//  MateriViewController.swift
//  victory
//
//  Created by Nicholas on 15/06/21.
//

import Foundation
import UIKit

class MateriViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var materiTitleNavigationItem: UINavigationItem!
    
    var praktikum = Constants.arrayOfPraktikum
    var praktikumTen: [Praktikum] = []
    var praktikumEleven: [Praktikum] = []
    var praktikumTwelve: [Praktikum] = []
    var selectedMatpelPraktikum: [[Praktikum]] = []
    var showAll = true
    
    var emptyStateImage = UIImage(systemName: "car")
    var emptyStateTitle = "Belum ada materi"
    var emptyStateSubtitle = "Nantikan materinya"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNotified(_:)),
                                               name: NSNotification.Name("menuUpdate"), object: nil)
        
        self.splitViewController?.presentsWithGesture = false
        setupTableView()
    }
    @objc func getNotified(_ object: Notification) {
        selectedMatpelPraktikum = []
        praktikumTen = []
        praktikumEleven = []
        praktikumTwelve = []
        if let menu = object.userInfo?["indexpath"] as? Int {
            switch menu {
            case 0:
                showAll = true
                materiTitleNavigationItem.title = "Semua Praktikum"
                tableView.reloadData()
            case 1:
                filterMateri(mapel: .fisika)
            case 2:
                filterMateri(mapel: .kimia)
            case 3:
                filterMateri(mapel: .biologi)
            case 4:
                filterMateri(mapel: .matematika)
            default:
                return
            }
        }
    }
    func filterMateri(mapel: Mapel) {
        showAll = false
        materiTitleNavigationItem.title = mapel.rawValue
        for (index, materi) in praktikum.enumerated() where praktikum[index].mataPelajaran == mapel {
            let grade = praktikum[index].kelas
            switch grade {
            case .k10:
                praktikumTen.append(materi)
            case .k11:
                praktikumEleven.append(materi)
            case .k12:
                praktikumTwelve.append(materi)
            }
        }
        selectedMatpelPraktikum = [praktikumTen, praktikumEleven, praktikumTwelve]
        tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.splitViewController?.hide(UISplitViewController.Column.primary)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.splitViewController?.show(UISplitViewController.Column.primary)
    }
}

extension MateriViewController: UITableViewDataSource, UITableViewDelegate {
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    func tableViewIdentifier() -> [String] {
        var identifier = [String]()
        if showAll {
            identifier.append(MateriTableViewCell.identifier)
        } else {
            for gradePraktikum in selectedMatpelPraktikum where !gradePraktikum.isEmpty {
                print("ADA")
                identifier.append(SubHeaderTableViewCell.identifier)
                identifier.append(MateriTableViewCell.identifier)
            }
            if identifier.isEmpty {
//                identifier.append(EmptyStateTableViewCell.identifier)
            }
        }
    return identifier
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tableViewIdentifier().count)
        return tableViewIdentifier().count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight = 236 // per cell
        let lineSpace = 12
        let bottomOffset = 40
        var totalRow = 0.0
        let numOfColumn = 3
        
        switch indexPath.row {
        case 0:
            if showAll {
                totalRow = ceil(Double(praktikum.count) / Double(numOfColumn))
                let totalLineSpace = (Int(totalRow) - 1) * lineSpace
                let totalHeight  = rowHeight * Int(totalRow) + bottomOffset + totalLineSpace
                return CGFloat(totalHeight)
            }
        case 1, 3, 5: // collection cell
            
            switch indexPath.row {
            case 1:
                totalRow = ceil(Double(praktikumTen.count) / Double(numOfColumn))
            case 3:
                totalRow = ceil(Double(praktikumEleven.count) / Double(numOfColumn))
            case 5:
                totalRow = ceil(Double(praktikumTwelve.count) / Double(numOfColumn))
            default:
                print("no cell")
            }
            let totalLineSpace = (Int(totalRow) - 1) * lineSpace
            let totalHeight  = rowHeight * Int(totalRow) + bottomOffset + totalLineSpace
            return CGFloat(totalHeight)

        default:
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = tableViewIdentifier()[indexPath.row]
        let currentCell = indexPath.row
        
        switch identifier {
        case SubHeaderTableViewCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
                    as? SubHeaderTableViewCell else { return UITableViewCell() }
            
            switch indexPath.row {
            case 0: // Kelas 10
                cell.classLbl.text = Constants.classes[0].getKelas()
            case 2: // Kelas 11
                cell.classLbl.text = Constants.classes[1].getKelas()
            case 4: // Kelas 12
                cell.classLbl.text = Constants.classes[2].getKelas()
            default:
                print("no cell found")
            }
            return cell
        case MateriTableViewCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
                    as? MateriTableViewCell else { return UITableViewCell() }
            
            switch indexPath.row {
            case 0:
                if showAll {
                    cell.selectedGradePraktikum = self.praktikum
                }
            case 1:
                cell.selectedGradePraktikum = self.praktikumTen
            case 3:
                cell.selectedGradePraktikum = self.praktikumEleven
            case 5:
                cell.selectedGradePraktikum = self.praktikumTwelve
            default:
                print("no cell found")
            }
            
            cell.didSelectItemAction = { [weak self] indexPath in
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                guard let destVC = storyBoard.instantiateViewController(withIdentifier: "MediaViewControllerScene") as?
                        MediaViewController else { return }
                if self?.showAll == true {
                    destVC.selectedPraktikum = self?.praktikum[indexPath.row]
                } else {
                    switch currentCell {
                    case 0:
                        destVC.selectedPraktikum = self?.praktikum[indexPath.row]
                    case 1:
                        destVC.selectedPraktikum = self?.praktikumTen[indexPath.row]
                    case 3:
                        destVC.selectedPraktikum = self?.praktikumEleven[indexPath.row]
                    case 5:
                        destVC.selectedPraktikum = self?.praktikumTwelve[indexPath.row]
                    default:
                        print("no cell found")
                    }
                }
                self?.navigationController?.pushViewController(destVC, animated: true)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

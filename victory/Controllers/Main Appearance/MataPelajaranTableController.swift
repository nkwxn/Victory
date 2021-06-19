// swiftlint:disable trailing_whitespace
//
//  TabelEksperimenController.swift
//  victory
//
//  Created by Nicholas on 03/06/21.
//

import UIKit

class MataPelajaranTableController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.subjects.count + 1 // for Semua Praktikum
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MataPelajaranTableViewCell", for: indexPath)
                as? MataPelajaranTableViewCell else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.matpelImageView.image = UIImage(systemName: "book")
            cell.matpelLbl.text = "Semua Praktikum"
            setToSelectdTableCell(cell: cell)
        default:
            cell.matpelImageView.image = Constants.subjects[indexPath.row-1].getImage()
            cell.matpelLbl.text = Constants.subjects[indexPath.row-1].rawValue
            setToNormalTableCell(cell: cell)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        
        guard let firstCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                as? MataPelajaranTableViewCell else { return }
        setToNormalTableCell(cell: firstCell)
        
        guard let cell = tableView.cellForRow(at: indexPath)
                as? MataPelajaranTableViewCell else { return }
        setToSelectdTableCell(cell: cell)
        
        let userinfo: [String: Int] = ["indexpath": indexPath.row]
        NotificationCenter.default.post(name: NSNotification.Name("menuUpdate"), object: nil, userInfo: userinfo)
    }
    private func setToSelectdTableCell(cell: MataPelajaranTableViewCell) {
        cell.cardBg.backgroundColor = UIColor(named: "vc_blue_active")
        cell.matpelImageView.tintColor = UIColor.white
        cell.matpelLbl.textColor = UIColor.white
    }
    private func setToNormalTableCell(cell: MataPelajaranTableViewCell) {
        cell.cardBg.backgroundColor = UIColor(named: "vc_side_menu")
        cell.matpelImageView.tintColor = UIColor(named: "vc_blue_active")
        cell.matpelLbl.textColor = UIColor.black
    }
}

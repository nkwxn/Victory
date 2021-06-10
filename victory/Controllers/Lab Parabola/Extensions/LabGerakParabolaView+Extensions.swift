//
//  LabGerakParabolaView+Extensions.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class CustomClearTabl: UITableViewCell {
    override class func awakeFromNib() {
        
    }
}

extension LabGerakParabolaView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Isi headerview tergantung context
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "VarHeader") as! LabVariableHeaderView
        
        // Setting variabel untuk button dan kawan2 nya
        switch section {
        case 0:
            headerView.lblHeaderTitle.text = "Variabel"
            headerView.btnHeader.setTitle("", for: .normal)
            headerView.btnHeader.isEnabled = false
        default:
            if nomorLab != nil {
                headerView.lblHeaderTitle.text = "Lembar Kerja"
                headerView.btnHeader.setTitle("Lihat Panduan", for: .normal)
            } else {
                headerView.lblHeaderTitle.text = "Posisi"
                headerView.btnHeader.setTitle("", for: .normal)
                headerView.btnHeader.isEnabled = false
            }
        }
        return headerView
    }
    
    // Jumlah tergantung section dan context
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nomorLab != nil {
            switch section {
            case 0:
                return 3
            default:
                return 6
            }
        } else {
            switch section {
            case 0:
                return 5
            default:
                return 4
            }
        }
    }
    
    // Cell tergantung section dan context
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let nomorLab = nomorLab {
            switch indexPath.section {
            case 0:
                if indexPath.row < 2 {
                    // Show the TableViewCell for default things
                    let cell = UITableViewCell()
                    cell.textLabel?.text = "Cell"
                    return cell
                } else {
                    // Show the custom cell with slider
                    let cell = tableView.dequeueReusableCell(withIdentifier: "VariableSliderCell", for: indexPath) as! VariabelCell
                    cell.lblVarName.text = "Asdf \(indexPath.row)"
                    return cell
                }
            default:
                if indexPath.row == 0 {
                    // Dequeue the LKS Header Table
                    let cell = tableView.dequeueReusableCell(withIdentifier: "LKSHeader", for: indexPath)
                    return cell
                } else {
                    // Dequeue the LKS Worksheet
                    let cell = tableView.dequeueReusableCell(withIdentifier: "LKSContent", for: indexPath)
                    return cell
                }
            }
        } else {
            switch indexPath.section {
            case 0:
                if indexPath.row < 4 {
                    let editor = variabelEdit[indexPath.row]
                    let cell = tableView.dequeueReusableCell(withIdentifier: "VariableSliderCell", for: indexPath) as! VariabelCell
                    cell.variableSetting = editor
                    cell.delegate = self
                    
                    return cell
                } else {
                    let cell = UITableViewCell()
                    cell.imageView?.image = UIImage(named: "gravity")
                    cell.textLabel?.text = "Gravitasi"
                    cell.detailTextLabel?.text = "Bumi: 10m/s²"
                    cell.accessoryType = .disclosureIndicator
                    return cell
                }
            default:
                let cell = UITableViewCell()
                cell.textLabel?.text = "Cell"
                return cell
            }
        }
    }
}

extension LabGerakParabolaView: VariableSliderDelegate {
    func sendSliderValue(from sliderValue: Float) {
        print(sliderValue)
    }
}

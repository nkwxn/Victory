//
//  LabGerakParabolaView+Extensions.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

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
        let sliderValues: [SliderVariable] = [.massaProyektil, .sudutLemparan, .kecAwal] // Determining the values shown
        var staticVal = sliderValues // Determining the static values (non-editable)
        
        if let nomorLab = nomorLab {
            staticVal.remove(at: nomorLab)
            switch indexPath.section {
            case 0:
                if indexPath.row < 2 {
                    let valew = staticVal[indexPath.row]
                    // Show the TableViewCell for default things
                    let cell = CustomClearTabl(image: valew.getImage(), title: "\(valew.rawValue) (\(valew.getAcronym()))", detail: "\(valew.getDefaultValue()) \(valew.getUnit())", showAcc: false)
                    return cell
                } else {
                    // Show the custom cell with slider
                    let cell = tableView.dequeueReusableCell(withIdentifier: "VariableSliderCell", for: indexPath) as! VariabelCell
                    cell.delegate = self
                    cell.variableSetting = sliderValues[nomorLab]
                    return cell
                }
            default:
                if indexPath.row == 0 {
                    // Dequeue the LKS Header Table
                    let cell = tableView.dequeueReusableCell(withIdentifier: "LKSHeader", for: indexPath) as! rowLKSHeaderCell
                    cell.varLKS = sliderValues[nomorLab]
                    return cell
                } else {
                    // Dequeue the LKS Worksheet
                    let cell = tableView.dequeueReusableCell(withIdentifier: "LKSContent", for: indexPath) as! rowLKSBodyCell
                    cell.variableSetup = sliderValues[nomorLab]
                    cell.angkaSoal = sliderValues[nomorLab].getLembarKerjaValues()[indexPath.row - 1]
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
                    let cell = CustomClearTabl(image: UIImage(named: "gravity"), title: "Gravitasi", detail: "Bumi: 10m/s²", showAcc: true)
                    return cell
                }
            default:
                let cell: UITableViewCell?
                switch indexPath.row {
                case 0:
                    cell = CustomClearTabl(image: UIImage(systemName: "stopwatch"), title: "Waktu", detail: "30 s", showAcc: false)
                case 1:
                    cell = CustomClearTabl(image: UIImage(systemName: "arrow.left.and.right.circle"), title: "Jarak (X(t))", detail: "100 m", showAcc: false)
                case 2:
                    cell = CustomClearTabl(image: UIImage(systemName: "arrow.up.and.down.circle"), title: "Waktu", detail: "0 m", showAcc: false)
                case 3:
                    cell = CustomClearTabl(image: UIImage(systemName: "speedometer"), title: "Kecepatan (v(t))", detail: "0 m/s", showAcc: false)
                default:
                    cell = UITableViewCell()
                }
                return cell!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if nomorLab == nil && indexPath == IndexPath(row: 4, section: 0) {
            // Show the Popover (ipad) / modal (iphone) choosing gravity
            if UIDevice.current.userInterfaceIdiom == .pad {
                // Show popover modal for the gravity choice
                let gravityPOver = GravityPopoverViewController()
                gravityPOver.modalPresentationStyle = .popover
                
                // Sisanya dah mabok gua wkwkw
            } else if UIDevice.current.userInterfaceIdiom == .phone {
                let gravityAlert = UIAlertController(title: "Gravitasi", message: "Pilihan planet:", preferredStyle: .actionSheet)
            }
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

class CustomClearTabl: UITableViewCell {
    init(image: UIImage?, title label: String, detail detailLabel: String, showAcc: Bool) {
        super.init(style: .value1, reuseIdentifier: nil)
        self.backgroundColor = .clear
        self.imageView?.image = image
        self.imageView?.tintColor = .black
        self.textLabel?.text = label
        self.detailTextLabel?.text = detailLabel
        self.accessoryType = showAcc ? .disclosureIndicator : .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = nil) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("Not init")
    }
}

extension LabGerakParabolaView: VariableSliderDelegate {
    func sendSliderValue(from sliderValue: Float) {
        print(sliderValue)
    }
}

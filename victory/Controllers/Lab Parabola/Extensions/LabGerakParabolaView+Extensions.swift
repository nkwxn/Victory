//
//  LabGerakParabolaView+Extensions.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit
import SpriteKit

extension LabGerakParabolaView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // MARK: - Cell Header
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
                headerView.delegate = self
            } else {
                headerView.lblHeaderTitle.text = "Posisi"
                headerView.btnHeader.setTitle("", for: .normal)
                headerView.btnHeader.isEnabled = false
            }
        }
        return headerView
    }
    
    // MARK: - Jumlah Cell sesuai dengan context praktikum (tanpa dan dengan lks)
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
    
    // MARK: - Tampilan Cell untuk setiap rows nya
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
                    let cell = tableView.dequeueReusableCell(withIdentifier: "VariableSliderCell", for: indexPath) as! VariableSliderCell
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
                    cell.lksIndexPath = indexPath
                    cell.delegate = self
                    return cell
                }
            }
        } else {
            switch indexPath.section {
            case 0:
                if indexPath.row < 4 {
                    let editor = variabelEdit[indexPath.row]
                    let cell = tableView.dequeueReusableCell(withIdentifier: "VariableSliderCell", for: indexPath) as! VariableSliderCell
                    cell.variableSetting = editor
                    cell.delegate = self
                    
                    return cell
                } else {
                    let cell = CustomClearTabl(image: UIImage(named: "gravity"), title: "Gravitasi", detail: "Bumi: 10.0 m/s²", showAcc: true)
                    return cell
                }
            default:
                let cell: UITableViewCell?
                switch indexPath.row {
                case 0:
                    cell = CustomClearTabl(image: UIImage(systemName: "stopwatch"), title: "Waktu", detail: "30 s", showAcc: false)
                case 1:
                    cell = CustomClearTabl(image: UIImage(systemName: "arrow.left.and.right.circle"), title: "Jarak (xₜ)", detail: "100 m", showAcc: false)
                case 2:
                    cell = CustomClearTabl(image: UIImage(systemName: "arrow.up.and.down.circle"), title: "Tinggi (yₜ)", detail: "0 m", showAcc: false)
                case 3:
                    cell = CustomClearTabl(image: UIImage(systemName: "speedometer"), title: "Kecepatan (vₜ)", detail: "0 m/s", showAcc: false)
                default:
                    cell = UITableViewCell()
                }
                return cell!
            }
        }
    }
    
    // MARK: - Row Selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if nomorLab == nil && indexPath == IndexPath(row: 4, section: 0) {
            // Show the Popover (ipad) / modal (iphone) choosing gravity
            if UIDevice.current.userInterfaceIdiom == .pad {
                // Show popover modal for the gravity choice
                let gravityChoice = GravityPopoverViewController()
                gravityChoice.parentTable = tableView
                gravityChoice.parentIndexPath = indexPath
                gravityChoice.delegate = self
                gravityChoice.modalPresentationStyle = .popover
                gravityChoice.preferredContentSize = CGSize(width: 200, height: 200)
                let popover: UIPopoverPresentationController = gravityChoice.popoverPresentationController!
                popover.sourceView = tableView.cellForRow(at: indexPath)
                
                // Sisanya isi coding untuk menampilkan action sheet / popover
                delegate?.presentView(gravityChoice, completion: nil)
            } else if UIDevice.current.userInterfaceIdiom == .phone {
                let gravityChoice = UIAlertController(title: "Gravitasi", message: "Pilihan planet:", preferredStyle: .actionSheet)
                // TODO: Tambahkan AlertAction beserta actionnnya untuk memilih planet
                
                let planets: [Planet] = [.earth, .moon, .mars, .jupiter]
                for p in planets {
                    let planetAction = UIAlertAction(title: "\(p.rawValue): \(p.getGravityValue()) m/s²", style: .default) { _ in
                        self.chosenPlanet = p
                        tableView.deselectRow(at: indexPath, animated: true)
                    }
                    gravityChoice.addAction(planetAction)
                }
                
                gravityChoice.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in tableView.deselectRow(at: indexPath, animated: true) })
                
                // Sisanya isi coding untuk menampilkan action sheet / popover
                delegate?.presentView(gravityChoice, completion: nil)
            }
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension LabGerakParabolaView: SKViewDelegate, SKSceneDelegate {
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        if let scene = scene as? SpriteScene {
            if nomorLab == nil {
                // Update di TableView
                guard let cellWaktu = variableTableView.cellForRow(at: IndexPath(row: 0, section: 1)),
                      let cellJarak = variableTableView.cellForRow(at: IndexPath(row: 1, section: 1)),
                      let cellTinggi = variableTableView.cellForRow(at: IndexPath(row: 2, section: 1)),
                      let cellKecepatan = variableTableView.cellForRow(at: IndexPath(row: 3, section: 1))
                else { return }
                
                if timeMasterClicked == false {
                    if scene.jarakXRealtime < scene.jarakXMaxReal {
                        cellJarak.detailTextLabel?.text = "\(round(scene.getJarakXRealtime() * 100) / 100) m"
                        cellTinggi.detailTextLabel?.text = "\(round(scene.getJarakYRealtime() * 100) / 100) m"
                        cellKecepatan.detailTextLabel?.text = "\(round(scene.getKecepatanTotal() * 100) / 100)"
                        cellWaktu.detailTextLabel?.text = "\(round(scene.getWaktuRealtime() * 100) / 100) s"
                    } else {
                        cellJarak.detailTextLabel?.text = "\(round(scene.jarakXMaxReal * 100) / 100) m"
                        
                        cellKecepatan.detailTextLabel?.text = "0 m/s"
                        cellWaktu.detailTextLabel?.text = "\(round(scene.totalWaktuReal * 100) / 100) s"
                        
                        if scene.ketinggianReal == 0 {
                            cellTinggi.detailTextLabel?.text = "\(scene.ketinggianReal)"
                        } else {
                            cellTinggi.detailTextLabel?.text = "\(-scene.ketinggianReal)"
                        }
                    }
                }
                
                // Update di UIView Statistik
                self.infoTitikTertinggi.text = "\(round(engine.titikTertinggiDariKecepatanAwalReal(kecepatanAwal: Float(kecepatanAwal), sudutTembak: sudutLemparan, gravitasi: gravitasiVektor)*100)/100) m"
                self.infoTotalJangkauan.text = "\(round(scene.getJarakXMaxReal()*100)/100) m"
                self.waktuTempuh.text = "\(round(scene.totalWaktuReal * 100) / 100) s"
                self.waktuTitikTertinggi.text = "\(round(scene.totalWaktuReal / 2)) s"
            }
        }
    }
}

// MARK: - Delegate jika tombol pada header disentuh (should open popover) dan untuk memilih gravitasi
extension LabGerakParabolaView: VariableHeaderDelegate, GravityPopoverDelegate, rowLKSBodyDelegate {
    func getCorrectValidation(_ threeFieldsCorrect: Bool, ip forLKS: IndexPath) {
        print("Should get validation from all TableViewCell")
        guard let nomorLab = nomorLab else { return }
        if forLKS.section == 1 {
            self.arrLKSRowValidation[forLKS.row - 1] = threeFieldsCorrect
        }
        let allRowVal = arrLKSRowValidation.allSatisfy {
            $0 == true
        }
        delegate?.validateLKS(forLabSection: nomorLab, lksCorrect: allRowVal)
    }
    
    func chooseGravity(chosenValue planet: Planet) {
        chosenPlanet = planet
        gravitasiVektor = (Float(-chosenPlanet.getGravityValue()))
        if let scene = skView.scene as? SpriteScene {
            scene.gravitasiVektor = gravitasiVektor
        }
    }
    
    func actionForButton(button selectedButton: UIButton) {
        // Open popover for panduan if the button is on the right popover
        let panduanVC = PanduanViewController()
        panduanVC.panduanLabArray = nomorLab
        panduanVC.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = panduanVC.popoverPresentationController!
        popover.sourceView = selectedButton
        delegate?.presentView(panduanVC, completion: nil)
    }
}

// MARK: - Custom Class untuk Clear TableView
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

// MARK: - Delegate untuk perubahan value pada slider (GUNAKAN UNTUK MEMANIPULASI PHYSICS BODY PADA SKSCENE!)
extension LabGerakParabolaView: VariableSliderDelegate {
    // MARK: - variabel sementara taro sini dlu yaa, ntar baru rapihin
    
    
    
    
    func sendSliderValue(from sliderValue: Float, withUnit: SliderVariable?) {
        guard let unit = withUnit?.getUnit() else { return }
        print("\(sliderValue) \(unit)")
        
        guard let scene = skView.scene as? SpriteScene else { return }
        
        switch withUnit {
        
        case .sudutLemparan:
            sudutFirstDummy = Double(sliderValue)
                    if sudutFirstDummy < 90 {
                        sudutLemparan = sudutFirstDummy
                    } else {
                        sudutLemparan = 89.99999
                    }
//            totalWaktuEngine = engine.waktuUntukJarakTerjauhEngine(kecepatanAwal: Float(kecepatanAwal), sudutTembak: sudutLemparan, gravitasi: gravitasiVektor, ketinggian: ketinggianEngine)
//            totalWaktuReal = engine.waktuUntukJarakTerjauhReal(kecepatanAwal: Float(kecepatanAwal), sudutTembak: sudutLemparan, gravitasi: gravitasiVektor, ketinggian: ketinggianReal)
            
            scene.sudutTembakScene = sudutLemparan
            scene.totalWaktuEngine = totalWaktuEngine
            scene.totalWaktuReal = totalWaktuReal
            
        case .massaProyektil:
            self.massaProyektil = Double(sliderValue)
            
        case .kecAwal:
            self.kecepatanAwal = Double(sliderValue)
            
//            totalWaktuEngine = engine.waktuUntukJarakTerjauhEngine(kecepatanAwal: Float(kecepatanAwal), sudutTembak: sudutLemparan, gravitasi: gravitasiVektor, ketinggian: Float(ketinggianAwal))
//
//            totalWaktuReal = engine.waktuUntukJarakTerjauhReal(kecepatanAwal: Float(kecepatanAwal), sudutTembak: sudutLemparan, gravitasi: gravitasiVektor, ketinggian: Float(ketinggianAwal))
            
          
                scene.totalWaktuEngine = totalWaktuEngine
                scene.kecAwalScene = Float(kecepatanAwal)
                scene.totalWaktuReal = totalWaktuReal
            
        case .ketAwal:
            self.ketinggianAwal = Double(sliderValue)
            ketinggianReal = sliderValue
            ketinggianEngine = sliderValue * 50
            
//            totalWaktuEngine = engine.waktuUntukJarakTerjauhEngine(kecepatanAwal: Float(kecepatanAwal), sudutTembak: sudutLemparan, gravitasi: gravitasiVektor, ketinggian: ketinggianEngine)
//            totalWaktuReal = engine.waktuUntukJarakTerjauhReal(kecepatanAwal: Float(kecepatanAwal), sudutTembak: sudutLemparan, gravitasi: gravitasiVektor, ketinggian: ketinggianReal)
            
            scene.initialY = scene.size.height * 0.5 + CGFloat(ketinggianEngine)
            scene.totalWaktuEngine = totalWaktuEngine
            scene.totalWaktuReal = totalWaktuReal
            scene.ketinggianReal = ketinggianReal
            scene.ketinggianEngine = ketinggianEngine
            
           
        default:
            print("Unit not identified")
        }
    }
}

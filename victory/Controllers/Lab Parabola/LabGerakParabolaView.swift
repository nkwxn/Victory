// swiftlint:disable trailing_whitespace
// swiftlint:disable inclusive_language
// swiftlint:disable line_length
// swiftlint:disable function_body_length
//
//  LabGerakParabolaView.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit
import SpriteKit

class LabGerakParabolaView: UIView {
    @IBOutlet weak var variableTableView: UITableView!
    @IBOutlet weak var skView: SKView!

    // Bottom Bar Button
    @IBOutlet weak var btnTampilkanMateri: UIButton!
    @IBOutlet weak var btnResetVariabel: UIButton!
    @IBOutlet weak var btnLuncurkan: UIButton!
    @IBOutlet weak var sliderPosisi: UISlider!
    
    // Constraint height untuk ngumpetin statistik dan keterangan
    @IBOutlet weak var heightStatistik: NSLayoutConstraint!
    @IBOutlet weak var heightDisclaimer: NSLayoutConstraint!
    
    // Label statistik freestyle
    @IBOutlet weak var infoTotalJangkauan: UILabel!
    @IBOutlet weak var waktuTempuh: UILabel!
    @IBOutlet weak var infoTitikTertinggi: UILabel!
    @IBOutlet weak var waktuTitikTertinggi: UILabel!
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    // Nomor lab sesuai dengan nomor soal (0-2) dan selesai / belum, sertakan delegate
    var nomorLab: Int?
    var arrLKSRowValidation: [Bool] = [false, false, false, false, false]
    let variabelEdit: [SliderVariable] = [.sudutLemparan, .massaProyektil, .kecAwal, .ketAwal]
    var done: Bool = false
    var chosenPlanet: Planet = .earth {
        didSet {
            // Change the content of Planet Cell
            let pathToPlanet = IndexPath(row: 4, section: 0)
            if nomorLab == nil {
                if let cellMoon = variableTableView.cellForRow(at: pathToPlanet) {
                    cellMoon.detailTextLabel?.text = "\(chosenPlanet.rawValue): \(chosenPlanet.getGravityValue()) m/s²"
                }
            }
        }
    }
    
//    var engine = VictoryEngine()
    var sudutLemparan = 30.0
    var massaProyektil = 50.0
    var kecepatanAwal = 15.0
    var ketinggianAwal = 0.0
//
//    var gravitasi = 9.8
        var sudutFirstDummy: Double = 45
        var engine = VictoryEngine()
        var gravitasiVektor : Float = -10
        var totalWaktuEngine : Float = 0
        var totalWaktuReal : Float = 0
        var waktuEngine : Float = 0
        var waktuRealtime : Float = 0
        var posisiXRealTime: Float = 0
        var posisiYRealTime: Float = 0
        var posisiXMaxReal : Float = 0
    
        var kecTotal : Float = 0
        var kecepatanXReal : Float = 0
        var kecepatanYReal : Float = 0
//        var ketinggianReal : Float = 0
        var ketinggianEngine : Float = 0
    
        var perpindahanXDalamPoin : Float = 0
        var timeMasterClicked = false
        var sliderPressed = false
    
        var initialX : Float = 0
        var initialY : Float = 0
    
    
    
    var delegate: LabGerakParabolaDelegate?
    
    init(frame: CGRect, noLab: Int? = nil) {
        super.init(frame: frame)
        nomorLab = noLab
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() {
        let bundle = Bundle.init(for: LabGerakParabolaView.self)
        if let viewFromXIB = bundle.loadNibNamed("LabGerakParabola", owner: self, options: nil),
           let parabolaView = viewFromXIB.first as? UIView {
            // Initializing the views
            // Adding Subviews
            addSubview(parabolaView)
            parabolaView.frame = self.bounds
            parabolaView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            totalWaktuEngine = engine.waktuUntukJarakTerjauhEngine(kecepatanAwal: Float(kecepatanAwal),
                                                                   sudutTembak: sudutLemparan, gravitasi: gravitasiVektor,
                                                                   ketinggian: ketinggianEngine )
            
            totalWaktuReal =  engine.waktuUntukJarakTerjauhReal(kecepatanAwal: Float(kecepatanAwal), sudutTembak: sudutLemparan, gravitasi: gravitasiVektor, ketinggian: Float(ketinggianAwal))
        }
        initViews()
    }
    func initViews() {
        // Ngumpetin view sesuai dengan pilihan antara lab dan freestyle
        if nomorLab != nil {
            heightStatistik.constant = 0
        } else {
            heightDisclaimer.constant = 0
        }
        // TableView Delegate and DataSource
        variableTableView.dataSource = self
        variableTableView.delegate = self
        
        // Register Custom Cells
        variableTableView.register(UINib(nibName: "LabVariableHeader", bundle: nil),
                                   forHeaderFooterViewReuseIdentifier: "VarHeader")
        variableTableView.register(UINib(nibName: "VariabelCell", bundle: nil),
                                   forCellReuseIdentifier: "VariableSliderCell")
        variableTableView.register(UINib(nibName: "rowLKSHeaderCell", bundle: nil), forCellReuseIdentifier: "LKSHeader")
        variableTableView.register(UINib(nibName: "rowLKSBodyCell", bundle: nil), forCellReuseIdentifier: "LKSContent")
        
        // Button Appearance
        btnTampilkanMateri.alignVerticalCenter()
        btnResetVariabel.alignVerticalCenter()
        btnLuncurkan.alignVerticalCenter()
        
        // Hide on different mode
        if nomorLab != nil {
            btnTampilkanMateri.isHidden = true
            btnResetVariabel.setTitle("Reset Tampilan", for: .normal)
        }
        
        // SpriteKit Scene Setup
        let sceneGerakParabola = SpriteScene(size: skView.bounds.size)
        sceneGerakParabola.delegate = self
        skView.delegate = self
        skView.presentScene(sceneGerakParabola)
    }
    
    @IBAction func sliderPosisiValueChanged(_ sender: UISlider) {
        print("ini slider value \(sender.value)")
        timeMasterClicked = true
        sliderPressed = false
        
        totalWaktuEngine = engine.waktuUntukJarakTerjauhEngine(kecepatanAwal: Float(kecepatanAwal), sudutTembak: sudutLemparan, gravitasi: gravitasiVektor, ketinggian: ketinggianEngine)
        totalWaktuReal = engine.waktuUntukJarakTerjauhReal(kecepatanAwal: Float(kecepatanAwal), sudutTembak: sudutLemparan, gravitasi: gravitasiVektor, ketinggian: Float(ketinggianAwal))
        
        waktuEngine = totalWaktuEngine * sender.value
        waktuRealtime = totalWaktuReal * sender.value
        
        if let gameScene = skView.scene as? SpriteScene {
            gameScene.lineActive = false
            
            let posisiX = engine.xProyektilTerhadapWaktuEngine(kecepatanAwal: Float(kecepatanAwal),
                                                               sudutTembak: sudutLemparan, waktu: waktuEngine)
            
            posisiXMaxReal = Float(engine.xProyektilTerhadapWaktuReal(kecepatanAwal: Float(kecepatanAwal),
                                                                      sudutTembak: sudutLemparan, waktu: totalWaktuReal))
            posisiXRealTime = Float(engine.xProyektilTerhadapWaktuReal(kecepatanAwal: Float(kecepatanAwal),
                                                                       sudutTembak: sudutLemparan, waktu: waktuRealtime))
            if waktuRealtime < totalWaktuReal {
                kecepatanXReal = Float(engine.kecepatanXAwalReal(sudutTembak: sudutLemparan,
                                                                 kecepatanAwal: Float(kecepatanAwal)))
                kecepatanYReal = Float(engine.kecepatanY(sudutTembak: sudutLemparan,
                                                         kecepatanAwal: Float(kecepatanAwal), waktu: waktuRealtime,
                                                         gravitasi: gravitasiVektor))
                
                let kecepatanXKuadrat = pow(kecepatanXReal, 2)
                let kecepatanYKuadrat = pow(kecepatanYReal, 2)
                kecTotal = pow(kecepatanXKuadrat + kecepatanYKuadrat, 0.5)
            } else {
                kecepatanXReal = 0
                kecepatanYReal = 0
                kecTotal = 0
            }
            
            let posisiY = engine.yProyektilTerhadapWaktuEngine(kecepatanAwal: Float(kecepatanAwal),
                                                               sudutTembak: sudutLemparan, waktu: waktuEngine,
                                                               gravitasi: gravitasiVektor)
            
            posisiYRealTime = Float(engine.yProyektilTerhadapWaktuReal(kecepatanAwal: Float(kecepatanAwal),
                                                                       sudutTembak: sudutLemparan, waktu: waktuRealtime,
                                                                       gravitasi: gravitasiVektor))

            gameScene.currentProjectile?.physicsBody?.velocity = .zero
            gameScene.currentProjectile?.physicsBody?.affectedByGravity = false
            gameScene.currentProjectile?.position = CGPoint(x: posisiX + gameScene.player.position.x,
                                                            y: posisiY + gameScene.player.position.y)
            
            guard let cellWaktu = variableTableView.cellForRow(at: IndexPath(row: 0, section: 1)),
                  let cellJarak = variableTableView.cellForRow(at: IndexPath(row: 1, section: 1)),
                  let cellTinggi = variableTableView.cellForRow(at: IndexPath(row: 2, section: 1)),
                  let cellKecepatan = variableTableView.cellForRow(at: IndexPath(row: 3, section: 1))
            else { return }
            
            if posisiXRealTime < posisiXMaxReal {
                cellJarak.detailTextLabel?.text = "\(round(posisiXRealTime * 100) / 100) m"
                cellTinggi.detailTextLabel?.text = "\(round(posisiYRealTime * 100) / 100) m"
                cellKecepatan.detailTextLabel?.text = "\(round(kecTotal * 100) / 100)"
                cellWaktu.detailTextLabel?.text = "\(round(waktuRealtime * 100) / 100) s"
            } else {
                cellJarak.detailTextLabel?.text = "\(round(posisiXMaxReal * 100) / 100) m"
                cellKecepatan.detailTextLabel?.text = "0 m/s"
                cellWaktu.detailTextLabel?.text = "\(round(totalWaktuReal * 100) / 100) s"

                if posisiXRealTime < posisiXMaxReal {
                    cellJarak.detailTextLabel?.text = "\(round(posisiXRealTime * 100) / 100) m"
                    cellTinggi.detailTextLabel?.text = "\(round((posisiYRealTime + Float(ketinggianAwal)) * 100) / 100) m"
                    cellKecepatan.detailTextLabel?.text = "\(round(kecTotal * 100) / 100)"
                    cellWaktu.detailTextLabel?.text = "\(round(waktuRealtime * 100) / 100) s"
                } else {
                    cellJarak.detailTextLabel?.text = "\(round(posisiXMaxReal * 100) / 100) m"

                    cellKecepatan.detailTextLabel?.text = "0 m/s"
                    cellWaktu.detailTextLabel?.text = "\(round(totalWaktuReal * 100) / 100) s"
                    cellTinggi.detailTextLabel?.text = "\(0)"
//                    if ketinggianReal == 0 {
//                        cellTinggi.detailTextLabel?.text = "\(ketinggianReal)"
//                    } else {
//                        cellTinggi.detailTextLabel?.text = "\(-ketinggianReal)"
//                    }
                }
            }
        }
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        switch sender {
        case btnTampilkanMateri:
            print("Should show modal to materi")
            delegate?.presentView(MateriBelajarViewController(), completion: nil)
        case btnResetVariabel:
            print("Should reset appearance / all variables on the side")
            if nomorLab == nil {
                // Reset seluruhnya yang ada di sebelah kiri
                chosenPlanet = .earth
                guard let cellAngle = variableTableView.cellForRow(at: IndexPath(row: 0, section: 0))
                        as? VariableSliderCell,
                      let cellMass = variableTableView.cellForRow(at: IndexPath(row: 1, section: 0))
                        as? VariableSliderCell,
                      let cellVelocity = variableTableView.cellForRow(at: IndexPath(row: 2, section: 0))
                        as? VariableSliderCell,
                      let cellHeight = variableTableView.cellForRow(at: IndexPath(row: 3, section: 0))
                        as? VariableSliderCell
                else { return }
                
                // Set the slider value
                cellAngle.varSlider.setValue((cellAngle.variableSetting?.getDefaultValue())!, animated: true)
                cellMass.varSlider.setValue((cellMass.variableSetting?.getDefaultValue())!, animated: true)
                cellVelocity.varSlider.setValue((cellVelocity.variableSetting?.getDefaultValue())!, animated: true)
                cellHeight.varSlider.setValue((cellHeight.variableSetting?.getDefaultValue())!, animated: true)
                
                // Set the label value while resetting
                cellAngle.lblVarAmount.text = "\(cellAngle.varSlider.value.rounded()) \(cellAngle.variableSetting?.getUnit() ?? "")"
                cellMass.lblVarAmount.text = "\(cellMass.varSlider.value.rounded()) \(cellMass.variableSetting?.getUnit() ?? "")"
                cellVelocity.lblVarAmount.text = "\(cellVelocity.varSlider.value.rounded()) \(cellVelocity.variableSetting?.getUnit() ?? "")"
                cellHeight.lblVarAmount.text = "\(cellHeight.varSlider.value.rounded()) \(cellHeight.variableSetting?.getUnit() ?? "")"
            } else {
                // Reset variabel di sebelah kiri (kecuali lks) + clear all projectiles
                guard let editableVar = variableTableView.cellForRow(at: IndexPath(row: 2, section: 0))
                        as? VariableSliderCell else { return }
                editableVar.varSlider.setValue((editableVar.variableSetting?.getDefaultValue())!, animated: true)
                editableVar.lblVarAmount.text = "\(editableVar.varSlider.value.rounded()) \(editableVar.variableSetting?.getUnit() ?? "")"
            }
            
            self.sudutLemparan = Double(SliderVariable.sudutLemparan.getDefaultValue())
            self.massaProyektil = Double(SliderVariable.massaProyektil.getDefaultValue())
            self.kecepatanAwal = Double(SliderVariable.kecAwal.getDefaultValue())
            self.ketinggianAwal = Double(SliderVariable.ketAwal.getDefaultValue())
            self.ketinggianEngine = Float(ketinggianAwal * 15)
            self.gravitasiVektor = -10
            totalWaktuReal = engine.waktuUntukJarakTerjauhReal(kecepatanAwal: Float(kecepatanAwal), sudutTembak: sudutLemparan, gravitasi: gravitasiVektor, ketinggian: Float(ketinggianAwal))
            
            // Reset the sprite scene dots
            if let scene = skView.scene as? SpriteScene {
                scene.resetLab()
                scene.initialY = scene.size.height * 0.2 + CGFloat(ketinggianEngine)
                scene.kecAwalScene = Float(kecepatanAwal)
                scene.sudutTembakScene = sudutLemparan
                scene.ketinggianReal = Float(ketinggianAwal)
                scene.ketinggianEngine = Float(ketinggianAwal * 50)
                scene.gravitasiVektor = -10
                scene.totalWaktuReal = totalWaktuReal
            }
        case btnLuncurkan:
            print("Should launch projectile (Manipulate SKScene Actions)")
            
            timeMasterClicked = false
            sliderPressed = false
            if let parabolaScene = skView.scene as? SpriteScene {
                parabolaScene.shootStraight(kecAwal: Float(kecepatanAwal))
            }
        default:
            print("Button not identified")
        }
    }
}

enum SliderVariable: String {
    case sudutLemparan = "Sudut Lemparan"
    case massaProyektil = "Massa Proyektil"
    case kecAwal = "Kecepatan Awal"
    case ketAwal = "Ketinggian Awal"
    
    func getImage() -> UIImage? {
        switch self {
        case .sudutLemparan:
            return UIImage(named: "angle")
        case .massaProyektil:
            return UIImage(systemName: "scalemass")
        case .kecAwal:
            return UIImage(systemName: "speedometer")
        case .ketAwal:
            return UIImage(systemName: "arrow.up.and.down.circle")
        }
    }
    func getDefaultValue() -> Float {
        switch self {
        case .sudutLemparan:
            return 30
        case .massaProyektil:
            return 50
        case .kecAwal:
            return 15
        case .ketAwal:
            return 0
        }
    }
    func getAcronym() -> String {
        switch self {
        case .sudutLemparan:
            return "θ"
        case .massaProyektil:
            return "m"
        case .kecAwal:
            return "v₀"
        case .ketAwal:
            return "h₀"
        }
    }
    func getUnit() -> String {
        switch self {
        case .sudutLemparan:
            return "º"
        case .massaProyektil:
            return "kg"
        case .kecAwal:
            return "m/s"
        case .ketAwal:
            return "m"
        }
    }
    func getMinSlider() -> Float {
        switch self {
        case .sudutLemparan:
            return 0
        case .massaProyektil:
            return 1
        case .kecAwal:
            return 5
        case .ketAwal:
            return 0
        }
    }
    func getMaxSlider() -> Float {
        switch self {
        case .sudutLemparan:
            return 90
        case .massaProyektil:
            return 200
        case .kecAwal:
            return 15
        case .ketAwal:
            return 10
        }
    }
    func getLembarKerjaValues() -> [Int] {
        switch self {
        case .sudutLemparan:
            return [0, 30, 45, 60, 90]
        case .massaProyektil:
            return [1, 10, 50, 100, 200]
        case .kecAwal:
            return [25, 50, 75, 100, 125]
        default:
            return [Int]()
        }
    }
}

// Gerak Parabola Delegate
protocol LabGerakParabolaDelegate: AnyObject {
    func presentView(_ view: UIViewController, completion: (() -> Void)?)
    func validateLKS(forLabSection: Int, lksCorrect: Bool)
}

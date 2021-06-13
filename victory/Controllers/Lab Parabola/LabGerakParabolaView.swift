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
    @IBOutlet weak var infoTitilTertinggi: UILabel!
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
    let variabelEdit: [SliderVariable] = [.sudutLemparan, .massaProyektil, .kecAwal, .ketAwal]
    var done: Bool = false
    var chosenPlanet: Planet = .earth
    var delegate: LabGerakParabolaDelegate?
    
    init(frame: CGRect, noLab: Int? = nil) {
        super.init(frame: frame)
        nomorLab = noLab
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        let bundle = Bundle.init(for: LabGerakParabolaView.self)
        if let viewFromXIB = bundle.loadNibNamed("LabGerakParabola", owner: self, options: nil), let parabolaView = viewFromXIB.first as? UIView {
            // Initializing the views
            // Adding Subviews
            addSubview(parabolaView)
            parabolaView.frame = self.bounds
            parabolaView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
        variableTableView.register(UINib(nibName: "LabVariableHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "VarHeader")
        variableTableView.register(UINib(nibName: "VariabelCell", bundle: nil), forCellReuseIdentifier: "VariableSliderCell")
        variableTableView.register(UINib(nibName: "rowLKSHeaderCell", bundle: nil), forCellReuseIdentifier: "LKSHeader")
        variableTableView.register(UINib(nibName: "rowLKSBodyCell", bundle: nil), forCellReuseIdentifier: "LKSContent")
        
        // Button Appearance
        btnTampilkanMateri.alignVerticalCenter()
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
            return 100
        case .ketAwal:
            return 10
        }
    }
    
    func getAcronym() -> String {
        switch self {
        case .sudutLemparan:
            return "θ"
        case .massaProyektil:
            return "m"
        case .kecAwal:
            return "Vo"
        case .ketAwal:
            return "Ho"
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
            return 25
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
            return 125
        case .ketAwal:
            return 20
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

protocol LabGerakParabolaDelegate: AnyObject {
    func presentView(_ view: UIView)
}
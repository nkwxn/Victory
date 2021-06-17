//
//  rowLKSBodyCell.swift
//  victory
//
//  Created by Nicholas on 10/06/21.
//

import UIKit

class rowLKSBodyCell: UITableViewCell {
    @IBOutlet weak var lblUnitOfTest: UILabel!
    @IBOutlet weak var tfXmax: UITextField!
    @IBOutlet weak var tfYmax: UITextField!
    @IBOutlet weak var tfWaktuYMax: UITextField!
    
    // Data for the TableView Row and Delegate Setup
    var angkaSoal: Int? {
        didSet {
            guard let angkaSoal = angkaSoal else { return }
            lblUnitOfTest.text = "\(angkaSoal)"
        }
    }
    
    var variableSetup: SliderVariable?
    var delegate: rowLKSBodyDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tfXmax.delegate = self
        tfYmax.delegate = self
        tfWaktuYMax.delegate = self
    }
    
    // If end edit, validate answer
    @IBAction func tfEndEdit(_ sender: UITextField) {
    }
}

extension rowLKSBodyCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let angkaSoal = angkaSoal else { return }
        
        // Validasikan segalanya sesuai dengan hitungan
        var hasilXMax: Double
        var hasilYMax: Double
        var hasilTymax: Double
        
        var nilaiV0 = 15.0 // m/s
        var nilaiTeta = 30.0 // deg
        var nilaiMassa = 50.0 // kg
        
        // Count based on the variable setup
        switch variableSetup {
        case .massaProyektil:
            nilaiMassa = Double(angkaSoal)
        case .sudutLemparan:
            nilaiTeta = Double(angkaSoal)
        case .kecAwal:
            nilaiV0 = Double(angkaSoal)
        default:
            textField.backgroundColor = UIColor(named: "vc_green_bg")
        }
        
        hasilXMax = round(((nilaiV0 * nilaiV0)/10 * sin(2*(nilaiTeta * Double.pi / 180)))*1000)/1000
        hasilYMax = round(((nilaiV0 * nilaiV0 * sin(nilaiTeta * Double.pi / 180) * sin(nilaiTeta * Double.pi / 180)) / (2*10))*1000)/1000
        hasilTymax = round(((nilaiV0 * sin(nilaiTeta * Double.pi / 180)) / 10)*1000)/1000
        
        guard let textFieldValue = textField.text else { return }
        
        // Validate if true / false (Round into 3 decimal places)
        var validation: Bool
        switch textField {
        case tfXmax:
            validation = Double(textFieldValue) == hasilXMax
        case tfYmax:
            validation = Double(textFieldValue) == hasilYMax
        case tfWaktuYMax:
            validation = Double(textFieldValue) == hasilTymax
        default:
            validation = false
        }
        
        textField.backgroundColor = validation ? UIColor(named: "vc_green_bg") : UIColor(named: "vc_red_bg")
//        sender.layer.borderWidth = 1.0
//        sender.layer.borderColor = validation ? UIColor(named: "vc_green_active")?.cgColor : UIColor(named: "vc_red_active")?.cgColor
        
        if textFieldValue == "" {
            textField.backgroundColor = .systemBackground
        }
    }
}

protocol rowLKSBodyDelegate {
    func getCorrectValidation()
}

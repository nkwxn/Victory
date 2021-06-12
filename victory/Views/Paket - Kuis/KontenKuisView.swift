//
//  KontenKuisViewController.swift
//  victory
//
//  Created by Yuliana Aulele on 10/06/21.
//

import UIKit

class KontenKuisView: UIView {

    weak var delegate: PopUpDelegate?
    var jawabanList: [String] = []
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var nomorKuisLabel: UILabel!
    @IBOutlet weak var pertanyaanKuisLabel: UILabel!
    @IBOutlet weak var ceklisImage: UIImageView!
    
    @IBOutlet weak var jawabanAButton: UIButton!
    @IBOutlet weak var jawabanBButton: UIButton!
    @IBOutlet weak var jawabanCButton: UIButton!
    @IBOutlet weak var jawabanDButton: UIButton!
    @IBOutlet weak var jawabanTepatLabel: UILabel!
    @IBOutlet weak var pembahasanLabel: UILabel!
    
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var sebelumnyaLabel: UILabel!
    @IBOutlet weak var selanjutnyaLabel: UILabel!
    @IBOutlet weak var sebelumnyaButton: UIButton!
    @IBOutlet weak var selanjutnyaButton: UIButton!
    
    @IBAction func onPreviousButtonPressed(_ sender: UIButton) {
        changeCurrentNumber(by: -1)
        updateToPembahasanUI(pilihJawaban: jawabanList[currentNumber-1])
    }
    
    @IBAction func onNextButtonPressed(_ sender: UIButton) {
        switch currentNumber {
        case 5:
            delegate?.showSkorView()
        default:
            changeCurrentNumber(by: 1)
            if currentNumber < jawabanList.count {
                updateToPembahasanUI(pilihJawaban: jawabanList[currentNumber-1])
            }
            updateToDefaultUI()
        }
        
    }
    
    func updateToPembahasanUI(pilihJawaban: String){
        let jawabanBenar = Constants.pertanyaanArray[currentNumber - 1].jawabanBenar.prefix(1)
        jawabanAButton.isEnabled = false
        jawabanBButton.isEnabled = false
        jawabanCButton.isEnabled = false
        jawabanDButton.isEnabled = false
      
        ceklisImage.isHidden = false
        jawabanTepatLabel.isHidden = false
        pembahasanLabel.isHidden = false
        currentPageLabel.text = "\(currentNumber) / \(Constants.pertanyaanArray.count)"

        let kuis = Constants.pertanyaanArray[currentNumber - 1]
        jawabanTepatLabel.text = kuis.jawabanTepat
        pembahasanLabel.text = kuis.pembahasan
        nomorKuisLabel.text = kuis.nomor
        pertanyaanKuisLabel.text = kuis.pertanyaan
        jawabanAButton.setTitle ( kuis.jawaban[0], for: .normal)
        jawabanBButton.setTitle ( kuis.jawaban[1], for: .normal)
        jawabanCButton.setTitle ( kuis.jawaban[2], for: .normal)
        jawabanDButton.setTitle ( kuis.jawaban[3], for: .normal)
        
        jawabanAButton.backgroundColor = .systemBlue
        jawabanBButton.backgroundColor = .systemBlue
        jawabanCButton.backgroundColor = .systemBlue
        jawabanDButton.backgroundColor = .systemBlue


        if pilihJawaban == jawabanBenar {
            ceklisImage.image = UIImage(systemName: "checkmark.circle")
            ceklisImage.tintColor = .systemGreen
            switch pilihJawaban{
            case "A":
                jawabanAButton.backgroundColor = .systemGreen
            case "B":
                jawabanBButton.backgroundColor = .systemGreen
            case "C":
                jawabanCButton.backgroundColor = .systemGreen
            case "D":
                jawabanDButton.backgroundColor = .systemGreen
            default:
                return
            }
        } else {
            ceklisImage.image = UIImage(systemName: "xmark.circle")
            ceklisImage.tintColor = .systemRed
            switch pilihJawaban{
            case "A":
                jawabanAButton.backgroundColor = .systemRed
            case "B":
                jawabanBButton.backgroundColor = .systemRed
            case "C":
                jawabanCButton.backgroundColor = .systemRed
            case "D":
                jawabanDButton.backgroundColor = .systemRed
            default:
                return
            }
            
            switch jawabanBenar{
            case "A":
                jawabanAButton.backgroundColor = .systemGreen
            case "B":
                jawabanBButton.backgroundColor = .systemGreen
            case "C":
                jawabanCButton.backgroundColor = .systemGreen
            case "D":
                jawabanDButton.backgroundColor = .systemGreen
            default:
                return
            }
        }

        selanjutnyaButton.isEnabled = true
        selanjutnyaButton.tintColor = UIColor.systemBlue
        selanjutnyaLabel.textColor = UIColor.systemBlue
        
        if currentNumber == Constants.pertanyaanArray.count{
            selanjutnyaButton.setImage(UIImage(systemName: "flag.circle.fill"), for: .normal)
            selanjutnyaLabel.text = "Lihat Hasil"
        }
        if currentNumber == 1 {
            sebelumnyaButton.isHidden = true
            sebelumnyaLabel.isHidden = true
        }
        
    }

    
    @IBAction func onOptionButtonsPress (_ sender: UIButton) {
        let pilihJawaban = sender.currentTitle!.prefix(1)
        jawabanList.append(String(pilihJawaban))
        updateToPembahasanUI(pilihJawaban: String(pilihJawaban))
        
    }
    
    private func changeCurrentNumber (by number: Int){
        currentNumber += number
    }
    private func updateToDefaultUI() {
        let kuis = Constants.pertanyaanArray[currentNumber - 1]
        nomorKuisLabel.text = kuis.nomor
        pertanyaanKuisLabel.text = kuis.pertanyaan
        jawabanTepatLabel.isHidden = true
        pembahasanLabel.isHidden = true
        ceklisImage.isHidden = true
        jawabanAButton.setTitle ( kuis.jawaban[0], for: .normal)
        jawabanBButton.setTitle ( kuis.jawaban[1], for: .normal)
        jawabanCButton.setTitle ( kuis.jawaban[2], for: .normal)
        jawabanDButton.setTitle ( kuis.jawaban[3], for: .normal)
        jawabanAButton.isEnabled = true
        jawabanBButton.isEnabled = true
        jawabanCButton.isEnabled = true
        jawabanDButton.isEnabled = true
        jawabanAButton.backgroundColor = .systemBlue
        jawabanBButton.backgroundColor = .systemBlue
        jawabanCButton.backgroundColor = .systemBlue
        jawabanDButton.backgroundColor = .systemBlue
        currentPageLabel.text = "\(currentNumber) / \(Constants.pertanyaanArray.count)"
        
        sebelumnyaButton.isHidden = false
        sebelumnyaLabel.isHidden = false
        selanjutnyaButton.isEnabled = false
        selanjutnyaButton.tintColor = UIColor.systemGray
        selanjutnyaLabel.textColor = UIColor.systemGray
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
        
    private func commonInit() {
        Bundle.main.loadNibNamed("KontenKuisView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupView()
        
    }
    
    var currentNumber = 1
    
    private func setupView() {
        let kuis = Constants.pertanyaanArray[currentNumber - 1]
    
        ceklisImage.isHidden = true
        jawabanTepatLabel.isHidden = true
        pembahasanLabel.isHidden = true
        sebelumnyaLabel.isHidden = true
        sebelumnyaButton.isHidden = true
        
        nomorKuisLabel.text = kuis.nomor
        pertanyaanKuisLabel.text = kuis.pertanyaan
        jawabanAButton.setTitle ( kuis.jawaban[0], for: .normal)
        jawabanBButton.setTitle ( kuis.jawaban[1], for: .normal)
        jawabanCButton.setTitle ( kuis.jawaban[2], for: .normal)
        jawabanDButton.setTitle ( kuis.jawaban[3], for: .normal)
        
        currentPageLabel.text = "\(currentNumber) / \(Constants.pertanyaanArray.count)"
        
        selanjutnyaButton.tintColor = UIColor.gray
        selanjutnyaButton.isEnabled = false
        selanjutnyaLabel.textColor = UIColor.gray
        
    }
}



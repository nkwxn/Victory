//
//  KontenKuisViewController.swift
//  victory
//
//  Created by Yuliana Aulele on 10/06/21.
//

import UIKit

class KontenKuisView: UIView {
    
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
        setupToPembahasanUI(jawabanTerpilih: answerList[currentNumber - 1])
    }
    
    @IBAction func onNextButtonPressed(_ sender: UIButton) {
        switch currentNumber {
        case 5:
            delegate?.showSkorView(totalCorrectAnswer: totalCorrectAnswer, totalSoalKuis: totalSoalKuis)
        default:
            changeCurrentNumber(by: 1)
            if currentNumber <= answerList.count {
                setupToPembahasanUI(jawabanTerpilih: answerList[currentNumber - 1])
            } else {
                setupToDefaultUI()
            }
        }
    }
    
    @IBAction func onOptionButtonsPress (_ sender: UIButton) {
        let pilihJawaban = sender.currentTitle!.prefix(1)
        answerList.append(String(pilihJawaban))
        setupToPembahasanUI(jawabanTerpilih: String(pilihJawaban))
    }
    /*
    // Init Functions
    */
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
        // initial Default View Config
        
        buttonJawabanList = [jawabanAButton, jawabanBButton, jawabanCButton, jawabanDButton]
        setupToDefaultUI()
    }
    /*
    // UIView Setup Child Functions
    */
    weak var delegate: KuisViewControllerDelegate?
    var currentNumber = 1
    var answerList: [String] = []
    var totalCorrectAnswer = 0
    var totalSoalKuis = Constants.pertanyaanArray.count
    var buttonJawabanList: [UIButton] = []
    
    private func changeCurrentNumber (by number: Int){
        currentNumber += number
    }
    
    private func disableOptionButtons() {
        for button in buttonJawabanList {
            button.isEnabled = false
        }
    }
    
    private func enableOptionButtons() {
        for button in buttonJawabanList {
            button.isEnabled = true
        }
    }
    
    private func setupKuisComponentText(kuis: Kuis, isPembahasan: Bool) {
        nomorKuisLabel.text = kuis.nomor
        pertanyaanKuisLabel.text = kuis.pertanyaan
        
        if isPembahasan {
            jawabanTepatLabel.text = kuis.jawabanTepat
            pembahasanLabel.text = kuis.pembahasan
        }
    }
    
    private func showPembahasanComponents() {
        ceklisImage.isHidden = false
        jawabanTepatLabel.isHidden = false
        pembahasanLabel.isHidden = false
    }
    
    private func hidePembahasanComponents() {
        ceklisImage.isHidden = true
        jawabanTepatLabel.isHidden = true
        pembahasanLabel.isHidden = true
    }
    
    private func setupOptionBtnsText(kuis: Kuis) {
        for (index, button) in buttonJawabanList.enumerated() {
            button.setTitle(kuis.jawaban[index], for: .normal)
        }
    }
    
    private func resetOptionBtnsColor() {
        for button in buttonJawabanList {
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 8
        }
    }
    
    private func setupCheckListImgProperties(with imageName: String, color: UIColor) {
        ceklisImage.image = UIImage(systemName: imageName)
        ceklisImage.tintColor = color
    }
    
    private func enableNextBtn() {
        selanjutnyaButton.isEnabled = true
        selanjutnyaButton.tintColor = UIColor.systemBlue
        selanjutnyaLabel.textColor = UIColor.systemBlue
    }
    
    private func disableNextBtn() {
        selanjutnyaButton.isEnabled = false
        selanjutnyaButton.tintColor = UIColor.systemGray
        selanjutnyaLabel.textColor = UIColor.systemGray
    }
    
    private func showPrevBtn() {
        sebelumnyaButton.isHidden = false
        sebelumnyaLabel.isHidden = false
    }
    
    private func hidePrevBtn() {
        sebelumnyaLabel.isHidden = true
        sebelumnyaButton.isHidden = true
    }
    
    private func setupToolBarUI(isPembahasan: Bool) {
        currentPageLabel.text = "\(currentNumber) / \(totalSoalKuis)"
        
        if currentNumber == totalSoalKuis{
            selanjutnyaButton.setImage(UIImage(systemName: "flag.circle.fill"), for: .normal)
            selanjutnyaLabel.text = "Lihat Hasil"
        } else {
            selanjutnyaButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            selanjutnyaLabel.text = "Selanjutnya"
        }
        
        if isPembahasan {
            enableNextBtn()
        } else { disableNextBtn() }
        
        if currentNumber == 1 {
            hidePrevBtn()
        } else { showPrevBtn() }
    }
    /*
    // UIView Setup Main Functions: Pembahasan Kuis UI
    */
    private func setupToPembahasanUI(jawabanTerpilih: String) {
        let jawabanBenar = Constants.pertanyaanArray[currentNumber - 1].jawabanBenar.prefix(1)
        disableOptionButtons()
        resetOptionBtnsColor()
        showPembahasanComponents()
        
        let kuis = Constants.pertanyaanArray[currentNumber - 1]
        setupKuisComponentText(kuis: kuis, isPembahasan: true)
        setupOptionBtnsText(kuis: kuis)
        setupToolBarUI(isPembahasan: true)
        
        let valueTerpilih = JawabanKuis(rawValue: jawabanTerpilih)
        let indexTerpilih = valueTerpilih!.getIndex()
        
        let valueBenar = JawabanKuis(rawValue: String(jawabanBenar))
        let indexBenar = valueBenar!.getIndex()
        
        // Change option buttons' colors according to the answer
        if jawabanTerpilih == jawabanBenar {
            setupCheckListImgProperties(with: "checkmark.circle", color: .systemGreen)
            buttonJawabanList[indexTerpilih].backgroundColor = .systemGreen
            totalCorrectAnswer += 1
        } else {
            setupCheckListImgProperties(with: "xmark.circle", color: .systemRed)
            buttonJawabanList[indexTerpilih].backgroundColor = .systemRed
            buttonJawabanList[indexBenar].backgroundColor = .systemGreen
        }
    }
    /*
    // UIView Setup Main Functions: Default Kuis UI
    */
    private func setupToDefaultUI() {
        enableOptionButtons()
        resetOptionBtnsColor()
        hidePembahasanComponents()
        
        let kuis = Constants.pertanyaanArray[currentNumber - 1]
        setupKuisComponentText(kuis: kuis, isPembahasan: false)
        setupOptionBtnsText(kuis: kuis)
        setupToolBarUI(isPembahasan: false)
    }
    
}



//
//  KontenKuisViewController.swift
//  victory
//
//  Created by Yuliana Aulele on 10/06/21.
//

import UIKit

class KontenKuisView: UIView {

    @IBOutlet weak var nomorKuisLabel: UILabel!
    @IBOutlet weak var pertanyaanKuisLabel: UILabel!
    
    @IBOutlet weak var jawabanAButton: UIButton!
    @IBOutlet weak var jawabanBButton: UIButton!
    @IBOutlet weak var jawabanCButton: UIButton!
    @IBOutlet weak var jawabanDButton: UIButton!
    @IBOutlet weak var jawabanTepatLabel: UILabel!
    @IBOutlet weak var pembahasanLabel: UILabel!
    

    struct Kuis {
        let nomor: String
        let pertanyaan: String
        let jawaban: [String]
        let jawabanBenar: String
        let jawabanTepat: String
        let pembahasan: String
    }
    
    var pertanyaanAngka = 0
    

    @IBAction func tombolPress(_ sender: UIButton) {
        let pilihJawaban = sender.currentTitle!
        let jawabanBenar = Constants.pertanyaanArray[pertanyaanAngka].jawabanBenar
        
        jawabanTepatLabel.isHidden = false
        pembahasanLabel.isHidden = false
        
        let kuis = Constants.pertanyaanArray[pertanyaanAngka]
        jawabanTepatLabel.text = kuis.jawabanTepat
        pembahasanLabel.text = kuis.pembahasan
        
        
        if pilihJawaban == jawabanBenar {
            sender.backgroundColor = .systemGreen
        } else {
            sender.backgroundColor = .systemRed
        }
        

        if pertanyaanAngka < Constants.pertanyaanArray.count - 1{
            pertanyaanAngka += 1
        } else {
            pertanyaanAngka = 0
        }
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    @objc func updateUI() {
        let kuis = Constants.pertanyaanArray[pertanyaanAngka]
        nomorKuisLabel.text = kuis.nomor
        pertanyaanKuisLabel.text = kuis.pertanyaan
        jawabanTepatLabel.isHidden = true
        pembahasanLabel.isHidden = true
        jawabanAButton.setTitle ( kuis.jawaban[0], for: .normal)
        jawabanBButton.setTitle ( kuis.jawaban[1], for: .normal)
        jawabanCButton.setTitle ( kuis.jawaban[2], for: .normal)
        jawabanDButton.setTitle ( kuis.jawaban[3], for: .normal)
        jawabanAButton.backgroundColor = .systemBlue
        jawabanBButton.backgroundColor = .systemBlue
        jawabanCButton.backgroundColor = .systemBlue
        jawabanDButton.backgroundColor = .systemBlue
    }
}



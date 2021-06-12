//
//  StructEnum.swift
//  victory
//
//  Created by Nicholas on 02/06/21.
//

import Foundation
import UIKit

enum Kelas: Int {
    case k10 = 10
    case k11 = 11
    case k12 = 12
    
    func getImage() -> UIImage {
        switch self {
        case .k10:
            return UIImage(systemName: "tortoise")!
        case .k11:
            return UIImage(systemName: "hare")!
        case .k12:
            return UIImage(systemName: "bolt")!
        }
    }
}

enum Mapel: String {
    case fisika = "Fisika"
    case kimia = "Kimia"
    case biologi = "Biologi"
    case matematika = "Matematika"
    
    func getImage() -> UIImage {
        switch self {
        case .fisika:
            return UIImage(systemName: "thermometer.snowflake")!
        case .kimia:
            return UIImage(systemName: "drop.triangle")!
        case .biologi:
            return UIImage(systemName: "ladybug")!
        case .matematika:
            return UIImage(systemName: "function")!
        }
    }
}

struct Praktikum {
    var nama: String
    var gambar: UIImage
    var kelas: Kelas
    var mataPelajaran: Mapel
    var pertanyaanQuiz: [Question]
}

struct Question {
    let text: String
    
    //Multiple choice questions have multiple answers, an Array of Strings would work for our quiz data.
    let answers: [String]
    //Look at the data in the quiz array, there is a seperate string that is the correctAnswer.
    let rightAnswer: String
    
    let pembahasan: String
    
    //The initialiser needs to be updated to match the new multiple choice quiz data.
    init(q: String, a: [String], correctAnswer: String, solusi: String?) {
        text = q
        answers = a
        rightAnswer = correctAnswer
        pembahasan = solusi ?? "belum ada"
    }
}

struct TujuanPraktikum {
    var textTujuan: String
    var iconTujuan: UIImage
    // MARK: - INI NANTI DIDISKUIIN LAGI,PERLU PAKE ICON ATAU CUKUP DENGAN PENOMORAN AJA
}

struct AlatPraktikum {
    var namaAlat: String
    var deskripsiAlat: String
    var gambarAlat: UIImage
}

struct Panduanlab {
    var Langkah: [String]
}

enum Step: String, CaseIterable {
    case materi = "Materi"
    case labOne = "Lab 1"
    case labTwo = "Lab 2"
    case labThree = "Lab 3"
    case kuis = "Kuis"
    
    func getIndex() -> Int {
        switch self {
        case .materi:
            return 0
        case .labOne:
            return 1
        case .labTwo:
            return 2
        case .labThree:
            return 3
        case .kuis:
            return 4
        }
    }
}

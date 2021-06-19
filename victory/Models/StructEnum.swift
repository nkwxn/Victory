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
    /*
    // enum Functions
    */
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
    func getKelas() -> String {
        switch self {
        case .k10:
            return "Kelas 10"
        case .k11:
            return "Kelas 11"
        case .k12:
            return "Kelas 12"
        }
    }
}

enum Mapel: String {
    case fisika = "Fisika"
    case kimia = "Kimia"
    case biologi = "Biologi"
    case matematika = "Matematika"
    /*
    // enum Functions
    */
    func getImage() -> UIImage {
        switch self {
        case .fisika:
            return UIImage(systemName: "thermometer")!
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
    var subtitleMateri: String
    var pertanyaanQuiz: QuizBrain
    var currentStep: Step = .materi
    var stepUnlockList: [Step] = [.materi]
    var stepDoneList: [Step] = []
}

struct MediaPraktikum {
    var namaMedia: String
    var gambarMedia: UIImage
}

struct TipePraktikum {
    var namaTipe: String
    var gambarTipe: UIImage
}

struct TujuanPraktikum {
    var textTujuan: String
    var iconTujuan: UIImage
}

struct AlatPraktikum {
    var namaAlat: String
    var deskripsiAlat: String
    var gambarAlat: UIImage
}

struct Panduanlab {
    var langkah: [String]
}

enum Step: String, CaseIterable {
    case materi = "Materi"
    case labOne = "Lab 1"
    case labTwo = "Lab 2"
    case labThree = "Lab 3"
    case kuis = "Kuis"
    /*
    // enum Functions
    */
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
    func getImageActive() -> UIImage {
        switch self {
        case .materi:
            return UIImage(systemName: "1.circle.fill")!
        case .labOne:
            return UIImage(systemName: "2.circle.fill")!
        case .labTwo:
            return UIImage(systemName: "3.circle.fill")!
        case .labThree:
            return UIImage(systemName: "4.circle.fill")!
        case .kuis:
            return UIImage(systemName: "5.circle.fill")!
        }
    }
    func getImageNormal() -> UIImage {
        switch self {
        case .materi:
            return UIImage(systemName: "1.circle")!
        case .labOne:
            return UIImage(systemName: "2.circle")!
        case .labTwo:
            return UIImage(systemName: "3.circle")!
        case .labThree:
            return UIImage(systemName: "4.circle")!
        case .kuis:
            return UIImage(systemName: "5.circle")!
        }
    }
    func getImageLock() -> UIImage {
        return UIImage(systemName: "lock.circle")!
    }
    func getImageDoneNormal() -> UIImage {
        return UIImage(systemName: "checkmark.circle")!
    }
    func getImageDoneActive() -> UIImage {
        return UIImage(systemName: "checkmark.circle.fill")!
    }
}

class Quiz {
    let questionNumber: Int
    let question: String
    let options: [String]
    let correctAnswerKey: QuizOption
    let explaination: String
    /*
    // Init Functions
    */
    init(questionNumber: Int, question: String, options: [String],
         correctAnswerKey: QuizOption, explaination: String) {
        self.questionNumber = questionNumber
        self.question = question
        self.options = options
        self.correctAnswerKey = correctAnswerKey
        self.explaination = explaination
    }
}

enum QuizOption: String {
    case optionA = "A"
    case optionB = "B"
    case optionC = "C"
    case optionD = "D"
    /*
    // enum Functions
    */
    func getIndex() -> Int {
        switch self {
        case .optionA:
            return 0
        case .optionB:
            return 1
        case .optionC:
            return 2
        case .optionD:
            return 3
        }
    }
}

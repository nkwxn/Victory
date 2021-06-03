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
}

enum Mapel: String {
    case fisika = "Fisika"
    case kimia = "Kimia"
    case biologi = "Biologi"
    case matematika = "Matematika"
    
    func getImage() -> UIImage {
        switch self {
        case .fisika:
            return UIImage(named: "thermometer.snowflake")!
        case .kimia:
            return UIImage(named: "drop.triangle")!
        case .biologi:
            return UIImage(named: "ladybug")!
        case .matematika:
            return UIImage(named: "function")!
        default:
            return UIImage()
        }
    }
}

struct Praktikum {
    var nama: String
    var gambar: UIImage
    var kelas: Kelas
    
}

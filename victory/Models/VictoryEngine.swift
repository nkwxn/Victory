// swiftlint:disable implicit_getter
// swiftlint:disable identifier_name
//
//  VictoryEngine.swift
//  victory
//
//  Created by Jehnsen Hirena Kane on 09/06/21.
//

import UIKit
import SpriteKit

class VictoryEngine {
    /// set up ketinggian masih nunggu pengaturan boundary dari gamescene
    
    //for freestyle mode
    var kecAwal : Float = 100
    var sudutAwal : Double = 45
    var waktu : Double = 1
    var gravitasiReal : Float = 9.8
    var poinKeMeter : Float = 50
    
//    var dx: CGFloat {
//        get{
//            return CGFloat(kecAwal * Float(__cospi(sudutAwal/180)))
//        }
//    }
//
//    var dy: CGFloat {
//        get{
//            return CGFloat(kecAwal * Float(__sinpi(sudutAwal/180)))
//        }
//    }
//
//    var ketinggianMaxReal : Float {
//        get {
//            return (pow(kecAwal, 2) * pow(Float(__sinpi(sudutAwal/180)), 2))/(2*gravitasiReal)
//        }
//    }
//
    /*
    var ketinggianMaxEngine : Float {
        get {
            return (pow(kecAwal, 2) * pow(Float(__sinpi(sudutAwal/180)), 2))/(2*gravitasiEngine)
        }
    }
    var jarakMaxEngine : Float {
        get {
            return (pow(kecAwal,2)/gravitasiEngine) * Float(__sinpi((2*sudutAwal)/180))
        }
    }
 */
//
//    var jarakMaxReal : Float {
//        get {
//            return (pow(kecAwal,2)/gravitasiReal) * Float(__sinpi((2*sudutAwal)/180))
//        }
//    }
//
//    var waktuKetinggianMaxEngine: Float {
//        get {
//            return kecAwal * Float(__sinpi(sudutAwal/180)) / gravitasiEngine
//        }
//    }
    
//    var waktuKetinggianMaxReal: Float {
//        get {
//            return kecAwal * Float(__sinpi(sudutAwal/180)) / gravitasiReal
//        }
//    }
    
//    var waktuJarakMaxEngine: Float {
//        get {
//            return 2 * waktuKetinggianMaxEngine
//        }
//    }
    
//    var waktuJarakMaxReal: Float {
//        get {
//            return 2 * waktuKetinggianMaxReal
//        }
//    }
    
    
    //callable function
    func kecepatanXAwalEngine(sudutTembak: Double, kecepatanAwal: Float) -> CGFloat {
        return CGFloat(kecepatanAwal * poinKeMeter * Float(__cospi(sudutTembak/180)))
    }
    func kecepatanXAwalReal(sudutTembak: Double, kecepatanAwal: Float) -> CGFloat {
        return CGFloat(kecepatanAwal * Float(__cospi(sudutTembak/180)))
    }
    func kecepatanYAwalEngine(sudutTembak: Double, kecepatanAwal: Float) -> CGFloat {
        return CGFloat(kecepatanAwal * poinKeMeter * Float(__sinpi(sudutTembak/180)))
    }
    func kecepatanYAwalReal(sudutTembak: Double, kecepatanAwal: Float) -> CGFloat {
        return CGFloat(kecepatanAwal * Float(__sinpi(sudutTembak/180)))
    }
    func kecepatanX(sudutTembak: Double, kecepatanAwal: Float) -> CGFloat {
        return CGFloat(kecepatanAwal * Float(__cospi(sudutTembak/180)))
    }
    func sudutDariKecepatanAwalY(kecepatanAwal: Float, kecepatanAwalY: Float) -> Float {
        return asin(kecepatanAwalY/kecepatanAwal)*180/Float.pi
    }
    func sudutDariKecepatanAwalX(kecepatanAwal: Float, kecepatanAwalX: Float) -> Float {
        return acos(kecepatanAwalX/kecepatanAwal)*180/Float.pi
    }
    func titikTertinggiDariKecepatanAwalReal(kecepatanAwal: Float, sudutTembak: Double, gravitasi: Float) -> Float {
        return (pow(kecepatanAwal, 2) * pow(Float(__sinpi(sudutTembak/180)), 2))/(2 * -gravitasi)
    }
    func titikTertinggiDariKecepatanAwalYReal(kecepatanAwalY: Float, gravitasi: Float) -> Float {
        return (pow(kecepatanAwalY, 2))/(2 * -gravitasi)
    }
    func titikTertinggiDariKecepatanAwalY(kecepatanAwalY: Float, gravitasi: Float) -> Float {
        return (pow(kecepatanAwalY, 2))/(2*gravitasi)
    }
    func jarakTerjauhDariKecepatanAwalReal(kecepatanAwal: Float, sudutTembak: Double, gravitasi: Float) -> Float {
        return (pow(kecepatanAwal, 2) / -gravitasi) * Float(__sinpi((2*sudutTembak)/180))
    }
    func waktuUntukTitikTertinggiReal(kecepatanAwal: Float, sudutTembak: Double, gravitasi: Float) -> Float {
        return kecepatanAwal * Float(__sinpi(sudutTembak/180)) / -gravitasi
    }
    //    func waktuUntukJarakTerjauhEngine(kecepatanAwal: Float, sudutTembak:Double, gravitasi: Float) -> Float{
    //        return 2 * poinKeMeter * kecepatanAwal * Float(__sinpi(sudutTembak/180)) / (-gravitasi * 150)
    //    }
    func waktuUntukJarakTerjauhEngine(kecepatanAwal: Float, sudutTembak: Double, gravitasi: Float, ketinggian: Float)
    -> Float {
        if ketinggian == 0 {
            return 2 * poinKeMeter * kecepatanAwal * Float(__sinpi(sudutTembak/180)) / (-gravitasi * 150)
        } else {
            // Referensi
            // https://ftp.unpad.ac.id/bse/Kurikulum_2006/11_SMA/Praktis_belajar_fisika_SMA_XI_IPA_Aip_S_dkk.pdf
            let komponenNonQuadratic = kecepatanYAwalEngine(sudutTembak: sudutTembak, kecepatanAwal: kecepatanAwal)
            let komponenQuadratic = 0.5 * gravitasi * 150 // Emg pengen nilainya minus
            return Float(quadraticTimeSolver(quadraticValue: komponenQuadratic,
                                             nonQuadraticValue: Float(komponenNonQuadratic), constantValue: ketinggian))
        }
    }
    func waktuUntukJarakTerjauhReal(kecepatanAwal: Float, sudutTembak: Double, gravitasi: Float, ketinggian: Float)
    -> Float {
        if ketinggian == 0 {
            return 2 * kecepatanAwal * Float(__sinpi(sudutTembak/180)) / (-gravitasi)
        } else {
            // Referensi
            // https://ftp.unpad.ac.id/bse/Kurikulum_2006/11_SMA/Praktis_belajar_fisika_SMA_XI_IPA_Aip_S_dkk.pdf
            let komponenNonQuadratic = kecepatanYAwalReal(sudutTembak: sudutTembak, kecepatanAwal: kecepatanAwal)
            let komponenQuadratic = 0.5 * gravitasi // Emg pengen nilainya minus
            return Float(quadraticTimeSolver(quadraticValue: komponenQuadratic,
                                             nonQuadraticValue: Float(komponenNonQuadratic), constantValue: ketinggian))
        }
    }
    //    func waktuUntukJarakTerjauhReal(kecepatanAwal: Float, sudutTembak:Double, gravitasi: Float) -> Float{
    //        return 2 * kecepatanAwal * Float(__sinpi(sudutTembak/180)) / (-gravitasi)
    //    }
    /*
    // Fungsi Terhadap Waktu
    */
    func xProyektilTerhadapWaktuEngine(kecepatanAwal: Float, sudutTembak: Double, waktu: Float) -> CGFloat {
        return CGFloat(Double(kecepatanAwal * poinKeMeter) * __cospi(sudutTembak/180) * Double(waktu) )
    }
    func xProyektilTerhadapWaktuReal(kecepatanAwal: Float, sudutTembak: Double, waktu: Float) -> CGFloat {
        return CGFloat(Double(kecepatanAwal) * __cospi(sudutTembak/180) * Double(waktu) )
    }
    func yProyektilTerhadapWaktuEngine(kecepatanAwal: Float, sudutTembak: Double, waktu: Float, gravitasi: Float)
    -> CGFloat {
        let part1 = (kecepatanAwal * poinKeMeter * Float(__sinpi(sudutTembak/180) * Double(waktu)))
        let part2 = (0.5 * pow(Float(waktu), 2) * gravitasi * 150)
        return CGFloat(part1 + part2)
    }
    func yProyektilTerhadapWaktuReal(kecepatanAwal: Float, sudutTembak: Double, waktu: Float, gravitasi: Float)
    -> CGFloat {
        let part1 = (kecepatanAwal * Float(__sinpi(sudutTembak/180) * Double(waktu)))
        let part2 = (0.5 * pow(Float(waktu), 2) * -gravitasi)
        return CGFloat(part1 - part2)
    }
    func kecepatanY(sudutTembak: Double, kecepatanAwal: Float, waktu: Float, gravitasi: Float) -> CGFloat {
        return CGFloat((kecepatanAwal * Float(__sinpi(sudutTembak/180))) - (-gravitasi * waktu))
    }
    /*
    // Math Functions
    */
    func quadraticTimeSolver(quadraticValue: Float, nonQuadraticValue: Float, constantValue: Float) -> Double {
        let a = Double(quadraticValue)
        let b = Double(nonQuadraticValue)
        let c = Double(constantValue)
        let bSquared = b * b
        let discriminant = bSquared - (4 * a * c)
        let isImaginary = discriminant < 0
        let discrimimantAbsSqrt = sqrt(fabs(discriminant))
        if isImaginary {
//            print("X = (\(-b) + \(discrimimantAbsSqrt)i)/\(2*a) & (\(-b) - \(discrimimantAbsSqrt)i)/\(2*a)")
            fatalError("manya heueu nilainya imajiner")
        } else {
            let topFormula = -b + discrimimantAbsSqrt
            let bottomFormula = 2 * a
            let totalX = topFormula / bottomFormula
            //
            let topFormula2 = -b - discrimimantAbsSqrt
            let totalX2 = topFormula2 / bottomFormula
            
//            print("X = \(totalX) & \(totalX2)")
            if totalX >= 0 {
                return totalX
            } else {
                return totalX2
            }
        }
    }
}

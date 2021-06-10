//
//  VictoryEngine.swift
//  victory
//
//  Created by Jehnsen Hirena Kane on 09/06/21.
//

import UIKit

class VictoryEngine{
    /// set up ketinggian masih nunggu pengaturan boundary dari gamescene
    
    //for freestyle mode
    var kecAwal : Float = 100
    var sudutAwal : Double = 45
    var gravitasi : Float = 9.8
    
    var dx: CGFloat {
        get{
            return CGFloat(kecAwal * Float(__cospi(sudutAwal/180)))
        }
    }
    
    var dy: CGFloat {
        get{
            return CGFloat(kecAwal * Float(__sinpi(sudutAwal/180)))
        }
    }
    
    var ketinggianMax : Float {
        get {
            return (pow(kecAwal, 2) * pow(Float(__sinpi(sudutAwal/180)), 2))/(2*gravitasi)
        }
    }
    var jarakMax : Float {
        get {
            return (pow(kecAwal,2)/gravitasi) * Float(__sinpi((2*sudutAwal)/180))
        }
    }
    
    var waktuKetinggianMax: Float {
        get {
            return kecAwal * Float(__sinpi(sudutAwal/180)) / gravitasi
        }
    }
    
    var waktuJarakMax: Float {
        get {
            return 2 * waktuKetinggianMax
        }
    }
    
    //callable function
    func kecepatanXDariSudut(sudutTembak: Double, kecepatanAwal: Float) -> CGFloat {
        return CGFloat(kecepatanAwal * Float(__cospi(sudutTembak/180)))
    }
    
    func kecepatanYDariSudut(sudutTembak: Double, kecepatanAwal: Float) -> CGFloat {
        return CGFloat(kecepatanAwal * Float(__sinpi(sudutTembak/180)))
    }
    
    func sudutDariKecepatanAwalY(kecepatanAwal: Float, kecepatanAwalY: Float) -> Float {
        return asin(kecepatanAwalY/kecepatanAwal)*180/Float.pi
    }
    
    func sudutDariKecepatanAwalX(kecepatanAwal: Float, kecepatanAwalX: Float) -> Float {
        return acos(kecepatanAwalX/kecepatanAwal)*180/Float.pi
    }
    
    func titikTertinggiDariKecepatanAwal(kecepatanAwal: Float, sudutTembak: Double, gravitasi: Float) -> Float {
        return (pow(kecepatanAwal, 2) * pow(Float(__sinpi(sudutTembak/180)), 2))/(2*gravitasi)
    }
    
    func titikTertinggiDariKecepatanAwalY(kecepatanAwalY: Float, gravitasi: Float) -> Float {
        return (pow(kecepatanAwalY, 2))/(2*gravitasi)
    }
    
    func jarakTerjauhDariKecepatanAwal(kecepatanAwal: Float, sudutTembak: Double, gravitasi: Float) -> Float{
        return (pow(kecepatanAwal,2)/gravitasi) * Float(__sinpi((2*sudutTembak)/180))
    }
    
    func waktuUntukTitikTertinggi(kecepatanAwal: Float, sudutTembak:Double, gravitasi: Float) -> Float{
        return kecepatanAwal * Float(__sinpi(sudutTembak/180)) / gravitasi
    }
    
    func waktuUntukJarakTerjauh(kecepatanAwal: Float, sudutTembak:Double, gravitasi: Float) -> Float{
        return 2 * kecepatanAwal * Float(__sinpi(sudutTembak/180)) / gravitasi
    }
}


//
//  VictoryEngine.swift
//  victory
//
//  Created by Jehnsen Hirena Kane on 09/06/21.
//

import UIKit

struct VictoryEngine{
    
    func kecepatanXDariSudut(sudutTembak: Float, kecepatanAwal: Float) -> Float {
        return kecepatanAwal * cos(sudutTembak)
    }
    
    func kecepatanYDariSudut(sudutTembak: Float, kecepatanAwal: Float) -> Float {
        return kecepatanAwal * sin(sudutTembak)
    }
    
    func sudutDariKecepatanAwalY(kecepatanAwal: Float, kecepatanAwalY: Float) -> Float {
        return asin(kecepatanAwalY/kecepatanAwal)*180/Float.pi
    }
    
    func sudutDariKecepatanAwalX(kecepatanAwal: Float, kecepatanAwalX: Float) -> Float {
        return acos(kecepatanAwalX/kecepatanAwal)*180/Float.pi
    }
    
    func titikTertinggiDariKecepatanAwal(kecepatanAwal: Float, sudutTembak: Float, gravitasi: Float) -> Float {
        return (pow(kecepatanAwal, 2) * pow(sin(sudutTembak), 2))/(2*gravitasi)
    }
    
    func titikTertinggiDariKecepatanAwalY(kecepatanAwalY: Float, gravitasi: Float) -> Float {
        return (pow(kecepatanAwalY, 2))/(2*gravitasi)
    }
    
    func jarakTerjauhDariKecepatanAwal(kecepatanAwal: Float, sudutTembak: Float, gravitasi: Float) -> Float{
        return (pow(kecepatanAwal,2)/gravitasi)*sin(2*sudutTembak)
    }
    
}


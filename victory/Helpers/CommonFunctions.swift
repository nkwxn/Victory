//
//  CommonFunctions.swift
//  victory
//
//  Created by Wuri Dita on 18/06/21.
//

import Foundation
import UIKit

class CommonFunction {
    static let shared = CommonFunction()
    func showUnderConstructionAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Akan Hadir",
                                      message: "Fitur masih dalam pengembangan",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                fatalError()
            }
        }))
        return alert
    }
}

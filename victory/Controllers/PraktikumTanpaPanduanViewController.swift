//
//  PraktikumTanpaPanduanViewController.swift
//  victory
//
//  Created by Nicholas on 15/06/21.
//

import UIKit

class PraktikumTanpaPanduanViewController: UIViewController {
    var praktikum: Praktikum?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = praktikum?.nama
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Adding some ContainerView Tabs
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let freestyleLab = LabGerakParabolaView(frame: frame)
        freestyleLab.delegate = self
        self.view.addSubview(freestyleLab)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PraktikumTanpaPanduanViewController: LabGerakParabolaDelegate {
    func validateLKS(forLabSection: Int, lksCorrect: Bool) {
        print("This unused")
    }
    
    func presentView(_ view: UIViewController, completion: (() -> Void)?) {
        self.present(view, animated: true, completion: completion)
    }
}

//
//  XIBTryoutViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class XIBTryoutViewController: UIViewController {
    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize the tryout xib view
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
        let tryoutView = LabGerakParabolaView(frame: frame, noLab: 1) // noLab allowed values: 0, 1, 2, nil
        tryoutView.delegate = self
        containerView.addSubview(tryoutView)
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

extension XIBTryoutViewController: LabGerakParabolaDelegate {
    func presentView(_ view: UIViewController, completion: (() -> Void)? = nil) {
        self.present(view, animated: true, completion: completion)
    }
}

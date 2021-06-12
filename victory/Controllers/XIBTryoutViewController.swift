//
//  XIBTryoutViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

protocol PopUpDelegate: class {
    func moveToPanduanView()
    func closePanduanView()
}

class XIBTryoutViewController: UIViewController, PopUpDelegate {
    
    @IBOutlet weak var containerView: TimelineView!
    @IBOutlet weak var onBoardingView: OnBoardingView!
    @IBOutlet weak var panduanLabView: PanduanLabView!
    @IBOutlet weak var dimOverlayView: DimOverlayView!
    
    
    @IBAction func onOBButtonPressed(_ sender: Any) {
        showOnBoardingView()
    }
    
    @IBAction func onPanduanBtnPressed(_ sender: Any) {
        showPanduanView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTimelineView()
        setupPanduanLabView()
        setupOnboardingView()
        setupDimOverlayView()
        
        panduanLabView.isHidden = true
        dimOverlayView.isHidden = true
        onBoardingView.isHidden  = true
    }
    
    //Delegate Function
    func moveToPanduanView() {
        closeOnBoardingView()
        showPanduanView()
    }
    
    //Delegate Function
    func closePanduanView() {
        panduanLabView.isHidden = true
        dimOverlayView.isHidden = true
    }
    
    func closeOnBoardingView() {
        onBoardingView.isHidden = true
        dimOverlayView.isHidden = true
    }
    
    func showOnBoardingView() {
        onBoardingView.isHidden = false
        dimOverlayView.isHidden = false
    }
    
    func showPanduanView(){
        panduanLabView.isHidden = false
        dimOverlayView.isHidden = false
    }
    
    func setupTimelineView() {
        containerView.materiPill.layer.cornerRadius = 14
        containerView.materiPill.backgroundColor = UIColor.black
    }
    
    func setupOnboardingView() {
        onBoardingView.delegate = self
        onBoardingView.layer.cornerRadius = 13
        onBoardingView.layer.masksToBounds = true
        onBoardingView.actionBtn.layer.cornerRadius = 8
    }
    
    func setupDimOverlayView() {
        dimOverlayView.alpha = 0.6
    }
}

extension XIBTryoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupPanduanLabView() {
        panduanLabView.delegate = self
        panduanLabView.layer.cornerRadius = 13
        panduanLabView.layer.masksToBounds = true
        panduanLabView.tableView.delegate = self
        panduanLabView.tableView.dataSource = self
        
        panduanLabView.tableView.register(UINib(nibName: "PanduanTableViewCell", bundle: nil), forCellReuseIdentifier: "PanduanTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.panduanLabs[0].Langkah.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PanduanTableViewCell", for: indexPath) as! PanduanTableViewCell
        
        cell.panduanLbl.text = Constants.panduanLabs[0].Langkah[indexPath.row]
        
        switch indexPath.row {
        case 0:
            cell.panduanImageView.image = UIImage(systemName: "person.crop.circle.badge.checkmark")
        default:
            cell.panduanImageView.image = UIImage(systemName: "\(indexPath.row).circle")
        }
        
        return cell
        
    }
}

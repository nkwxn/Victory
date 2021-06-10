//
//  XIBTryoutViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class XIBTryoutViewController: UIViewController {
    
    @IBOutlet weak var containerView: TimelineView!
    @IBOutlet weak var onBoardingView: OnBoardingView!
    @IBOutlet weak var panduanLabView: PanduanLabView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.materiPill.layer.cornerRadius = 14
        containerView.materiPill.backgroundColor = UIColor.black
        
        onBoardingView.isHidden = true
        onBoardingView.layer.cornerRadius = 13
        onBoardingView.layer.masksToBounds = true
        onBoardingView.actionBtn.layer.cornerRadius = 8
        
        setupPanduanLabView()
    }
}

extension XIBTryoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupPanduanLabView() {
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

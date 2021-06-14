//
//  PanduanLab.swift
//  victory
//
//  Created by Wuri Dita on 10/06/21.
//

import UIKit

class PanduanLabView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func onCloseButtonPressed(_ sender: Any) {
        delegate?.closePanduanView()
    }
    
    weak var delegate: PraktikumBerpanduanViewControllerDelegate?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PanduanLabView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setupView()
    }
    
}

extension PanduanLabView: UITableViewDelegate, UITableViewDataSource {
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "PanduanTableViewCell", bundle: nil), forCellReuseIdentifier: "PanduanTableViewCell")
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

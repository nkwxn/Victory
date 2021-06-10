//
//  PanduanLab.swift
//  victory
//
//  Created by Wuri Dita on 10/06/21.
//

import UIKit

class PanduanLabView: UIView {
    
    @IBOutlet var contentView: PanduanLabView!
    @IBOutlet var tableView: UITableView!
    
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
    }
    
}

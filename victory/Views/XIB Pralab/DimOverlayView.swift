//
//  DimOverlayView.swift
//  victory
//
//  Created by Wuri Dita on 12/06/21.
//

import UIKit

class DimOverlayView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("DimOverlayView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}

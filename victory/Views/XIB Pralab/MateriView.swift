//
//  MateriView.swift
//  victory
//
//  Created by Wuri Dita on 11/06/21.
//

import UIKit
import WebKit

class MateriView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var webView: WKWebView!
    /*
    // Init Functions
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("MateriView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        // Setup web kit configurations
    }
}

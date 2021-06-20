//
//  MateriView.swift
//  victory
//
//  Created by Wuri Dita on 11/06/21.
//

import UIKit
import WebKit

class MateriBelajarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Initialize PanduanLabView
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let materiView = MateriView(frame: frame)
        self.view.addSubview(materiView)
    }
}

class MateriView: UIView, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var lanjutKeLabBtn: UIButton!
    @IBAction func onLanjutKeLabBtnPressed(_ sender: Any) {
        delegate?.showLabView()
    }
    var isURLLoaded = false
    weak var delegate: PraktikumBerpanduanViewControllerDelegate?
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
        setupButton()
        webView.uiDelegate = self
        webView.scrollView.delegate = self
        webView.navigationDelegate = self
        let url = Bundle.main.url(forResource: "index", withExtension: "html",
                                  subdirectory: "WebKitView/KontenMapel/Fisika/GerakParabola")!
        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isURLLoaded {
            if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height - 40) {
                lanjutKeLabBtn.isHidden = false
            } else {
                lanjutKeLabBtn.isHidden = true
            }
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isURLLoaded = true
    }
    func setupButton() {
        lanjutKeLabBtn.layer.cornerRadius = 8
        lanjutKeLabBtn.isHidden = true
    }
}

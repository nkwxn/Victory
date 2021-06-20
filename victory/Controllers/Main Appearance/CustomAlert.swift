// swiftlint:disable trailing_whitespace
//
//  AlertViewController.swift
//  victory
//
//  Created by Daniella Stefani on 15/06/21.
//

import UIKit

class MyAlert: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var tipePraktikum = Constants.arrayOfTipePraktikum
    weak var delegate: MediaViewControllerDelegate?
    
    struct AlertConstants {
        static let backgroundAlphaTo: CGFloat = 0.5
    }
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    func showAlert(with title: String, message: String, on viewController: MediaViewController) {
        guard let targetView = viewController.superview else {
            return
        }
        let currentWindow: UIWindow? = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        
        backgroundView.frame = targetView.bounds
        currentWindow?.addSubview(backgroundView)
        
        alertView.frame = CGRect(x: 277, y: 227, width: 640, height: 394)
        currentWindow?.addSubview(alertView)
        
        setupTitleLabel(with: title)
        setupCloseButton()
        setupTypeCollectionView()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = AlertConstants.backgroundAlphaTo
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.alertView.alpha = 1
                })
            }
        })
    }
    func setupTypeCollectionView() {
        let typeCollectionView: UICollectionView = UICollectionView(frame: (CGRect(x: 42, y: 91, width: 556,
                                                                                   height: 266)), collectionViewLayout:
                                                                                    UICollectionViewFlowLayout.init())
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        typeCollectionView.setCollectionViewLayout(layout, animated: true)
        typeCollectionView.backgroundColor = UIColor.clear
        
        typeCollectionView.dataSource = self
        typeCollectionView.delegate = self
        
        layout.itemSize = CGSize(width: 278, height: 266)
        layout.minimumInteritemSpacing = 0
        
        let nib = UINib(nibName: "\(GeneralCollectionViewCell.self)", bundle: nil)
        typeCollectionView.register(nib, forCellWithReuseIdentifier: "generalCollectionCell")
        alertView.addSubview(typeCollectionView)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tipePraktikum.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "generalCollectionCell",
                                                            for: indexPath) as? GeneralCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.generalCollectionImageView.image = tipePraktikum[indexPath.row].gambarTipe
        cell.generalCollectionTitleLabel.text = tipePraktikum[indexPath.row].namaTipe
        cell.generalCollectionView.backgroundColor = UIColor(named: "vc_blue_active")
        cell.generalCollectionTitleLabel.textColor = .white
        cell.generalCollectionTitleLabel.textAlignment = .center
        cell.generalCollectionSubtitleLabel.text = ""
        cell.heightConstraintsSubtitleLabel.constant = 0
        cell.heightConstraintImageView.constant = 200
        cell.heightConstraintsTitleLabel.constant = 16
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            delegate?.moveToDenganPanduan()
        } else {
            delegate?.moveToTanpaPanduan()
        }
        dismissAlert()
    }
    func setupTitleLabel(with title: String) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.size.width, height: 51))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor(named: "vc_tab_bar")
        titleLabel.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.03)
        titleLabel.shadowOffset = CGSize(width: titleLabel.frame.width, height: 0.3)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        alertView.addSubview(titleLabel)
    }
    func setupCloseButton() {
        let button = UIButton(frame: CGRect(x: 587, y: 4, width: 44, height: 44))
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.setTitleColor(UIColor(named: "vc_blue_active"), for: .normal)
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.addSubview(button)
    }
    @objc func dismissAlert() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.alpha = 0
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                }, completion: { done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                })
            }
        })
    }
}

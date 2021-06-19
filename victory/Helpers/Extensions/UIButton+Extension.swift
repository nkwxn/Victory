//
//  UIButton+Extension.swift
//  victory
//
//  Created by Nicholas on 10/06/21.
//

import UIKit

extension UIButton {
    func alignVerticalCenter(padding: CGFloat = 4.0) {
        guard let imageSize = imageView?.frame.size, let titleText = titleLabel?.text,
              let titleFont = titleLabel?.font else { return }
        let titleSize = (titleText as NSString).size(withAttributes: [.font: titleFont])
        let total = imageSize.height + titleSize.height + padding
        imageEdgeInsets = UIEdgeInsets(top: -(total - imageSize.height), left: 0, bottom: 0, right: -titleSize.width)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(total - titleSize.height), right: 0)
    }
}
/*
 @interface UIButton (VerticalLayout)

 - (void)centerVerticallyWithPadding:(float)padding;
 - (void)centerVertically;

 @end

 @implementation UIButton (VerticalLayout)

 - (void)centerVerticallyWithPadding:(float)padding
 {
     CGSize imageSize = self.imageView.frame.size;
     CGSize titleSize = self.titleLabel.frame.size;
     
     CGFloat totalHeight = (imageSize.height + titleSize.height + padding);
     
     self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
                                             0.0f,
                                             0.0f,
                                             - titleSize.width);
     
     self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                             - imageSize.width,
                                             - (totalHeight - titleSize.height),
                                             0.0f);
     
 }


 - (void)centerVertically
 {
     const CGFloat kDefaultPadding = 6.0f;
     
     [self centerVerticallyWithPadding:kDefaultPadding];
 }


 @end
 */

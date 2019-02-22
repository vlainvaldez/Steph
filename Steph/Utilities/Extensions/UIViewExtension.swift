//
//  UIViewExtension.swift
//  Steph
//
//  Created by Hero on 22/02/2019.
//  Copyright © 2019 Hero. All rights reserved.
//

import UIKit

extension UIView {
    
    func subview(forAutoLayout subview: UIView) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func subviews(forAutoLayout subviews: UIView...) {
        self.subviews(forAutoLayout: subviews)
    }
    
    func subviews(forAutoLayout subviews: [UIView]) {
        subviews.forEach(self.subview)
    }
}


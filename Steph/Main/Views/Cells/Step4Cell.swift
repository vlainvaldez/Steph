//
//  Step4Cell.swift
//  Steph
//
//  Created by Hero on 22/02/2019.
//  Copyright © 2019 Hero. All rights reserved.
//

import UIKit
import SnapKit

public final class Step4Cell: UICollectionViewCell {
    
    // MARK: Subviews
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public API
extension Step4Cell {
    public static var identifier: String = "Step4Cell"
}


//
//  Step3Cell.swift
//  Steph
//
//  Created by Hero on 22/02/2019.
//  Copyright © 2019 Hero. All rights reserved.
//

import UIKit
import SnapKit

public final class Step3Cell: UICollectionViewCell {
    
    // MARK: Subviews
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.brown
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public API
extension Step3Cell {
    public static var identifier: String = "Step3Cell"
}


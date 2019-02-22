//
//  Step2Cell.swift
//  Steph
//
//  Created by Novare Account on 22/02/2019.
//  Copyright © 2019 Novare Account. All rights reserved.
//

import UIKit
import SnapKit

public final class Step2Cell: UICollectionViewCell {
    
    // MARK: Subviews
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public API
extension Step2Cell {
    public static var identifier: String = "Step2Cell"
}

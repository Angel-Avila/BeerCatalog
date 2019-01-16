//
//  Label.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/14/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class Label: UILabel {
    init(fontName: String = "AvenirNext-Regular", size: CGFloat, textColor: UIColor) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.font = UIFont(name: fontName, size: size)
        self.textColor = textColor
        self.textAlignment = .center
        self.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

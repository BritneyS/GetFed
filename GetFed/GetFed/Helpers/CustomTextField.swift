//
//  CustomTextField.swift
//  GetFed
//
//  Created by Britney Smith on 12/7/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        underline()
    }
    
    func underline() {
        let border = CALayer()
        let width = CGFloat(1.25)
        let customBorderColor = UIColor(named: ColorID.AccentColorB.rawValue) ?? UIColor.black
        
        border.borderColor = customBorderColor.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

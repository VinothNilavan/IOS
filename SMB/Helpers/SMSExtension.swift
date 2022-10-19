//
//  SMSExtension.swift
//  SMB
//
//  Created by Vinoth on 24/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setBorder(width: CGFloat, color : UIColor) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color.cgColor
    }
    
    func makeRound () {
        self.layer.cornerRadius = self.bounds.size.width / 2.0
    }
    
    func putShadow () {
        self.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5.0
    }
    
    func putShadowUp () {
        self.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: -5)
        self.layer.shadowRadius = 5.0
    }
}
@IBDesignable
class RoundTextField : UITextField {
  @IBInspectable
    var cornerRadius : CGFloat = 0.0 {
    didSet {
        layer.cornerRadius  = cornerRadius
        layer.masksToBounds = cornerRadius > 0
    }
  }
}

class RoundedCornerView : UIView {
    override func awakeFromNib() {
        self.setup()
    }
    
    func setup(){
        self.layer.cornerRadius = 10.0
    }
}

class RoundedCornerButton : UIButton {
    override func awakeFromNib() {
        self.setup()
    }
    
    func setup() {
        self.layer.cornerRadius = 10.0
    }
}
extension UIColor {
    struct custom {
        static let appGreen = UIColor.init(red: 29/255.0, green: 105/255.0, blue: 36/255.0, alpha: 1)
    }
}

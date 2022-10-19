//
//  ProductCollectionViewCell.swift
//  SMB
//
//  Created by Vinoth on 23/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLbl: UILabel!

    func config(vm:ProductViewModel) {
        nameLbl.text = vm.displayName
        descLbl.text = vm.desc
        imageView.sd_setImage(with: URL.init(string: vm.imageUrl ?? "" ), placeholderImage: UIImage(), options:[], completed:nil)
    }
}
class ProductViewModel {
    var displayName : String?
    var imageUrl : String?
    var desc : String?
}

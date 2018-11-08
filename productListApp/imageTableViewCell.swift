//
//  imageTableViewCell.swift
//  iOSHW01
//
//  Created by Snigdha Bose on 11/6/18.
//  Copyright © 2018 UNC Charlotte. All rights reserved.
//

import UIKit

class imageTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dev: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
     @IBOutlet weak var smallimage: UIImageView!
    
    @IBOutlet weak var largeimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

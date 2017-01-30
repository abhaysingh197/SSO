//
//  accountEnableCell.swift
//  testFirst
//
//  Created by Singh, Abhay on 1/27/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit

protocol enableInAccount {
    func enableAccountAction(cell: accountEnableCell)
}

class accountEnableCell: UITableViewCell {
    
    var delegate: enableInAccount?

    @IBOutlet weak var userNameLabel: UILabel!


    @IBOutlet weak var switchLabel: UISwitch!
    
    @IBAction func switchAction(_ sender: Any) {
        delegate?.enableAccountAction(cell: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

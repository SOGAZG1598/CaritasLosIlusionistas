//
//  ProgramasTVC.swift
//  CaritasLosIlusionistas
//
//  Created by Carlos Valmaña Morales on 30/09/22.
//

import UIKit

class ProgramasTVC: UITableViewCell {

    @IBOutlet weak var programasView: UIView!
    
    @IBOutlet weak var programasImgView: UIImageView!
    
    @IBOutlet weak var programLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

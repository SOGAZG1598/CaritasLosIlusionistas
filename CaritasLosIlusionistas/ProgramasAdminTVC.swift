//
//  ProgramasAdminTVC.swift
//  CaritasLosIlusionistas
//
//  Created by Carlos Valmaña Morales on 30/09/22.
//

import UIKit

class ProgramasAdminTVC: UITableViewCell {

    @IBOutlet weak var programasAdminView: UIView!
    
    @IBOutlet weak var programasAdminImgView: UIImageView!
    
    @IBOutlet weak var programasAdminLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

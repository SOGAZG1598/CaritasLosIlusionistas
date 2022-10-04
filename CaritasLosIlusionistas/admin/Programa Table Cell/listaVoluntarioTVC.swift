//
//  listaVoluntarioTVC.swift
//  CaritasLosIlusionistas
//
//  Created by Alumno on 01/10/22.
//

import UIKit

class listaVoluntarioTVC: UITableViewCell {

    @IBOutlet weak var listaVolView: UIView!
    @IBOutlet weak var volLbl: UILabel!
    @IBOutlet weak var volIMGView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  perfilUsuarioViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit

class perfilUsuarioViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var lbNombreCompleto: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nombreCompleto = defaults.string(forKey: "nombreCompleto")!
        lbNombreCompleto.text = nombreCompleto
        // Do any additional setup after loading the view.
     
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

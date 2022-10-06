//
//  perfilAdminViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit

class perfilAdminViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cerrarSesionBoton(_ sender: UIButton) {
        defaults.removeObject(forKey: "idUsuarios")
        defaults.removeObject(forKey: "emailUsuarios")
        defaults.removeObject(forKey: "nombreCompleto")
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }


}

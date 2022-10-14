//
//  perfilAdminViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit

class perfilAdminViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var lbNombreCompleto: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nombreCompleto = defaults.string(forKey: "nombreCompleto")!
        lbNombreCompleto.text = nombreCompleto

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cerrarSesionBoton(_ sender: UIButton) {
        defaults.removeObject(forKey: "idUsuarios")
        defaults.removeObject(forKey: "emailUsuarios")
        defaults.removeObject(forKey: "nombreCompleto")
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    override var canBecomeFirstResponder: Bool {
            get {
                return true
            }
        }

        // Enable detection of shake motion
        override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            if motion == .motionShake {
                print("Why are you shaking me?")
                self.performSegue(withIdentifier: "editarAdminSegue", sender: nil)
            }
        }
}

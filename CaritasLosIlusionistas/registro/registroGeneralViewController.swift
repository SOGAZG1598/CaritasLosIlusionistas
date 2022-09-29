//
//  registroGeneralViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit

class registroGeneralViewController: UIViewController {

    @IBOutlet weak var lbEmailRegistro: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registroPrimeroAccion(_ sender: UIButton) {
        let emailusad = lbEmailRegistro.text!
        if emailusad.contains("@caritas.mx"){
            self.performSegue(withIdentifier: "adminRegistroSegue", sender: nil)
        }else{
            self.performSegue(withIdentifier: "usuarioRegistroSegue", sender: nil)
        }
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

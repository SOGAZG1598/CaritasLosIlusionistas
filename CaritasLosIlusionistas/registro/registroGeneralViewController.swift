//
//  registroGeneralViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit

class registroGeneralViewController: UIViewController {

    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var tfCurp: UITextField!
    
    @IBOutlet weak var tfNombre: UITextField!
    
    @IBOutlet weak var tfApellidoPaterno: UITextField!
    
    @IBOutlet weak var tfApellidoMaterno: UITextField!
    
    @IBOutlet weak var tfTelefono: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registroPrimeroAccion(_ sender: UIButton) {
        
        let emailusad = tfEmail.text!
        let password = tfPassword.text!
        let curp = tfCurp.text!
        let nombre = tfNombre.text!
        let apellidoP = tfApellidoPaterno.text!
        let apellidoM = tfApellidoMaterno.text!
        let telefono = tfTelefono.text!
    
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

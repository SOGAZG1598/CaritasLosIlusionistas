//
//  ViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit


//ESTE ES EL LOGIN
class ViewController: UIViewController {
    @IBOutlet weak var lbEmail: UITextField!
    @IBOutlet weak var lbPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //poner imagen fondo
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "PruebaWWP2")!)
    }

    @IBAction func loginAccion(_ sender: UIButton) {
        if lbEmail.text! == "1"{
            self.performSegue(withIdentifier: "adminPrincipalSegue", sender: nil)
        }else{
            self.performSegue(withIdentifier: "usuarioPrincipalSegue", sender: nil)
        }
    }
    
}


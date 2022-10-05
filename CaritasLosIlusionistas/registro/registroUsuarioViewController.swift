//
//  registroUsuarioViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit

class registroUsuarioViewController: UIViewController {

    
    
    @IBOutlet weak var tfNombreDeLugar: UITextField!
    
    @IBOutlet weak var tfDomicilio: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func crearVoluntario(_ sender: UIButton) {
        
        
        let nombreDelLugar = tfNombreDeLugar.text!
        let domicilio = tfDomicilio.text!
        
    
    
        
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
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

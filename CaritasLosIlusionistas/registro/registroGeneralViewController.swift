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
        
        
        let idUser = API_Registro()
        
        if emailusad.contains("@caritas.mx") && idUser != -1{
            self.performSegue(withIdentifier: "adminRegistroSegue", sender: nil)
        }else if idUser != -1{
            self.performSegue(withIdentifier: "usuarioRegistroSegue", sender: nil)
        }
    }
    
    func lecturaTextFields() -> [String:Any]? {
        
        if let emailusad = tfEmail.text, let password = tfPassword.text, let curp = tfCurp.text, let nombre = tfNombre.text, let apellidoP = tfApellidoPaterno.text, let apellidoM = tfApellidoMaterno.text, let telefono = tfTelefono.text, !emailusad.isEmpty , !password.isEmpty, !curp.isEmpty, !nombre.isEmpty , !apellidoM.isEmpty, !apellidoP.isEmpty , !telefono.isEmpty{
            
            let crearUsuario: [String: Any] = ["nombreUsuarios": nombre, "apellidoPaterno": apellidoP, "apellidoMaterno": apellidoM, "curpUsuarios": curp, "emailUsuarios": emailusad,"telefonoUsuarios": telefono,"passUsuarios": password]
            
            return crearUsuario
        }else{
            alertas(titulo: "Aviso", texto: "Espacio vacio y/o incorrecto")
        }
         //nunca se va usar, so
        return nil
        //["":""]
    }
    
    func API_Registro()->Int{
            var verificador = -1
            var Sverificador = ""
            
            //https://stackoverflow.com/a/60440711
            //let crearUsuario: [String: Any] = ["nombreUsuarios": "Juan", "apellidoPaterno": "Alberto", "apellidoMaterno": "Perez", "curpUsuarios": "BBABAB", "emailUsuarios": "@caritas.mx","telefonoUsuarios": "9959495646","passUsuarios": "123"]
            let crearUsuario = lecturaTextFields()
            //let vacioCrearUsuario : [String: Any] = ["":""]
            if crearUsuario == nil {
                return -1
            }
            
            let jsonData = try? JSONSerialization.data(withJSONObject: crearUsuario)

            // create post request
            let url = URL(string: "https://equipo05.tc2007b.tec.mx:10210/usuarios/crear")! //PUT Your URL
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            // insert json data to the request
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                Sverificador = (responseJSON as! [String: Any])["idUsuarios"] as! String
                print("mi datito es \(Sverificador)")
                
                
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON) //Code after Successfull POST Request
                    print(responseJSON["idUsuarios"]!)
                    
                    //guarda el datito en verificador
                    //let datito = responseJSON["idUsuarios"] as String
                    //verificador = Int(datito) ?? 0
                    //verificador = Integer.parseInt(jsonObj.get("id"));
                    //if let datito = responseJSON["idUsuarios"] as? Int{ verificador = datito}
                 
                }
            }
            
            task.resume()
            verificador = Int(Sverificador) ?? 0
            return 1
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func alertas(titulo:String , texto:String) ->Void{
        let alerta = UIAlertController(title:titulo, message: texto, preferredStyle: .alert)
        let botonCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alerta.addAction(botonCancel)
        present(alerta, animated: true)
    }

}

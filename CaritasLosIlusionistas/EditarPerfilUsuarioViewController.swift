//
//  EditarPerfilUsuarioViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Carlos Valmaña Morales on 05/10/22.
//

import UIKit

class EditarPerfilUsuarioViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var tfCurp: UITextField!
    
    @IBOutlet weak var tfNombre: UITextField!
    
    @IBOutlet weak var tfApellidoP: UITextField!
    
    @IBOutlet weak var tfApellidoM: UITextField!
    
    @IBOutlet weak var tfTelefono: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func GuardarBoton(_ sender: UIButton) {
        
        let idUser = API_Editar()
        
        if idUser != -1{
            alertas(titulo: "Aviso", texto: "Datos actualizados exitosamente ")
            self.dismiss(animated: true, completion: nil)
        }else{
            alertas(titulo: "Aviso", texto: "No se pudo actualizar la información.")
            self.dismiss(animated: true, completion: nil)
            
        }

    }
    
    
    func lecturaTextFields() -> [String:Any]? {
        
        if let emailusad = tfEmail.text, let password = tfPassword.text, let curp = tfCurp.text, let nombre = tfNombre.text, let apellidoP = tfApellidoP.text, let apellidoM = tfApellidoM.text, let telefono = tfTelefono.text, !emailusad.isEmpty , !password.isEmpty, !curp.isEmpty, !nombre.isEmpty , !apellidoM.isEmpty, !apellidoP.isEmpty , !telefono.isEmpty{
            
            let crearUsuario: [String: Any] = ["nombreUsuarios": nombre, "apellidoPaterno": apellidoP, "apellidoMaterno": apellidoM, "curpUsuarios": curp, "emailUsuarios": emailusad,"telefonoUsuarios": telefono,"passUsuarios": password, "idUsuarios": defaults.integer(forKey: "idUsuarios")]
            
            
            return crearUsuario
        }else{
            alertas(titulo: "Aviso", texto: "Espacio vacio y/o incorrecto")
        }
         //nunca se va usar, so
        return nil
        //["":""]
    }
    
        func API_Editar()->Int{
                
                //https://stackoverflow.com/a/60440711
                let crearUsuario = lecturaTextFields()
                if crearUsuario == nil {
                    return -1
                }
                
                let jsonData = try? JSONSerialization.data(withJSONObject: crearUsuario)

                // create post request
                let url = URL(string: "https://equipo05.tc2007b.tec.mx:10210/usuarios/editar")! //PUT Your URL
                var request = URLRequest(url: url)
                request.httpMethod = "PUT"
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
                    
                    
                    if let responseJSON = responseJSON as? [String: Any] {
                        print(responseJSON) //Code after Successfull POST Request
                     
                    }
                }
                
                task.resume()
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
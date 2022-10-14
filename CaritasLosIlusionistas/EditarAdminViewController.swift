//
//  EditarAdminViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Carlos Valmaña Morales on 06/10/22.
//

import UIKit
import CryptoKit

class EditarAdminViewController: UIViewController, UITextFieldDelegate {
    
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var tfCurp: UITextField!
    
    @IBOutlet weak var tfNombre: UITextField!
    
    @IBOutlet weak var tfPaterno: UITextField!
    
    @IBOutlet weak var tfMaterno: UITextField!
    
    @IBOutlet weak var tfTelefono: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func guardarBoton(_ sender: UIButton) {
        
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
        
        if let emailusad = tfEmail.text, let password = tfPassword.text, let curp = tfCurp.text, let nombre = tfNombre.text, let apellidoP = tfPaterno.text, let apellidoM = tfMaterno.text, let telefono = tfTelefono.text, !emailusad.isEmpty , !password.isEmpty, !curp.isEmpty, !nombre.isEmpty , !apellidoM.isEmpty, !apellidoP.isEmpty , !telefono.isEmpty{
            
            if password.count < 8 || curp.count < 18 || telefono.count > 15{
                alertas(titulo: "Aviso", texto: "Espacio vacio y/o incorrecto")
            }else{
                let passCrypt = encripta(password: "\(password).caritasPASS")
                let crearUsuario: [String: Any] = ["nombreUsuarios": nombre, "apellidoPaterno": apellidoP, "apellidoMaterno": apellidoM, "curpUsuarios": curp, "emailUsuarios": emailusad,"telefonoUsuarios": telefono,"passUsuarios": passCrypt]
                
                return crearUsuario
            }
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
    
    

        func alertas(titulo:String , texto:String) ->Void{
            let alerta = UIAlertController(title:titulo, message: texto, preferredStyle: .alert)
            let botonCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alerta.addAction(botonCancel)
            present(alerta, animated: true)
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
    func encripta(password:String) -> String {
            guard let data = password.data(using: .utf8) else { return "" }
            let digest = SHA256.hash(data: data)
            //print(digest.data) // 32 bytes
            //print(digest.hexStr) // B94D27B9934D3E08A52E52D7DA7DABFAC484EFE37A5380EE9088F7ACE2EFCDE9
            return digest.hexStr
        }

}

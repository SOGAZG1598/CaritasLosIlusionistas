//
//  registroGeneralViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit
import CryptoKit


class registroGeneralViewController: UIViewController, UITextFieldDelegate {
    
    let defaults = UserDefaults.standard

    
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
        
        if emailusad.contains("@caritas.org.mx") && idUser != -1{
            self.performSegue(withIdentifier: "adminRegistroSegue", sender: nil)
        }else if idUser != -1{
            self.performSegue(withIdentifier: "usuarioRegistroSegue", sender: nil)
        }
    }
    
    func lecturaTextFields() -> [String:Any]? {
        
        if let emailusad = tfEmail.text, let password = tfPassword.text, let curp = tfCurp.text, let nombre = tfNombre.text, let apellidoP = tfApellidoPaterno.text, let apellidoM = tfApellidoMaterno.text, let telefono = tfTelefono.text, !emailusad.isEmpty , !password.isEmpty, !curp.isEmpty, !nombre.isEmpty , !apellidoM.isEmpty, !apellidoP.isEmpty , !telefono.isEmpty{
            
            if password.count < 8 || curp.count == 19{
                alertas(titulo: "Aviso", texto: "Espacio con longitud no exacta")
            }else if !validate(password:password){
                alertas(titulo: "Aviso", texto: "La contraseña debe de tener cada uno de los 4 grupos: Mayúscula, minúscula, num3r0 y carácter  e$pecial!.")
            }
            else{
                let passCrypt = encripta(password: "\(password).caritasPASS")
                let crearUsuario: [String: Any] = ["nombreUsuarios": nombre, "apellidoPaterno": apellidoP, "apellidoMaterno": apellidoM, "curpUsuarios": curp, "emailUsuarios": emailusad,"telefonoUsuarios": telefono,"passUsuarios": passCrypt]
                
                return crearUsuario
            }
        }else{
            alertas(titulo: "Aviso", texto: "Espacio vacío y/o incorrecto")
        }
         //nunca se va usar, so
        return nil
        //["":""]
    }
    
    func API_Registro()->Int{
            var verificador = -1
            //var Sverificador = ""
            //https://stackoverflow.com/a/60440711
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
            //reparacion de la prof
            let group = DispatchGroup()
            group.enter()
            //inicia el request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data, error == nil else {
                            print(error?.localizedDescription ?? "No data")
                            return
                        }
                        
                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                        //Sverificador = (responseJSON as! [String: Any])["idUsuarios"] as! String
                        //print("mi datito es \(Sverificador)")
                        
                        
                        if let responseJSON = responseJSON as? [String: Int] {
                            print(responseJSON) //Code after Successfull POST Request
                            verificador = responseJSON["idUsuarios"]!
                            print(verificador)
                            self.defaults.setValue(verificador, forKey: "idUsuarios")
                        }
                        group.leave()
                    }
                    
                    task.resume()
                    group.wait()

                    verificador = defaults.integer(forKey: "idUsuarios")
                    print(verificador)
                    return verificador
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
    
    //https://stackoverflow.com/a/42929273
    func validate(password: String) -> Bool {
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: password) else { return false }

        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard texttest1.evaluate(with: password) else { return false }

        let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        guard texttest2.evaluate(with: password) else { return false }

        return true
    }
}

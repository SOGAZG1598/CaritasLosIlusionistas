//
//  ViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit
import CryptoKit

extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var hexStr: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}

//ESTE ES EL LOGIN
class ViewController: UIViewController, UITextFieldDelegate {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var lbEmail: UITextField!
    @IBOutlet weak var lbPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //poner imagen fondo
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "PruebaWWP2")!)
        
        
    }

    @IBAction func loginAccion(_ sender: UIButton) {
        let emailusad = lbEmail.text!
        let loginExitoso = llamadaAPI_Login()
        
        if emailusad.contains("@caritas.org.mx") && loginExitoso{
            self.performSegue(withIdentifier: "adminPrincipalSegue", sender: nil)
        }else if loginExitoso{
            self.performSegue(withIdentifier: "usuarioPrincipalSegue", sender: nil)
        }
    }
    
    func llamadaAPI_Login() ->Bool{
        var emailBuscar = ""
        var contra = ""
        var idUsuario = 0
        var nombreCompleto = ""
        
        var loginExitoso = false
        var notificacion = ""
        
        // CHECA SI HAY ESPACIOS VACIOS
        if (lbEmail != nil && lbPass.text != ""){
            emailBuscar = lbEmail.text!
            contra = lbPass.text!
        }else{
            //emailBuscar.text = "hugo"
            alertas(titulo: "Aviso", texto: "Uno de los campos esta vacio")
            return loginExitoso
        }
        //INICIA API
        guard let url = URL(string:"https://equipo05.tc2007b.tec.mx:10210/usuarios/login?emailUsuarios=\(emailBuscar)")
        else {
            return loginExitoso
        }
        
        let grupo = DispatchGroup()
        grupo.enter()
    
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            /*
            if let data = data, let string = String(data: data, encoding: .utf8){
                print(string)
            }
             */
            
        let decoder = JSONDecoder()

                    if let data = data{
                        do{
                            let tasks = try decoder.decode([Usuario].self, from: data)
                            if (!tasks.isEmpty){
                                tasks.forEach{ i in
                                    print("-------- USUARIO ---------")
                                    print("Id Usuario: \(i.idUsuarios)" )
                                    print("Password: \(i.passUsuarios)" )
                                    print("Nombre: \(i.nombreUsuarios)" )
                                    
                                    idUsuario = Int(i.idUsuarios)
                                    nombreCompleto = "\(i.nombreUsuarios) \(i.apellidoPaterno) \(i.apellidoMaterno)"
                                    
                                    let passRAW = "\(contra).caritasPASS"
                                    print(passRAW)
                                    let password = self.encripta(password: passRAW)
                                    print(password)
                                    
                                    if(i.passUsuarios == password){
                                        print("Login exitoso")
                                        //METAN TODOS LOS DATOS A DEFAULTS y activarle el segue
                                        self.defineDefaults_Login(id: idUsuario, email: emailBuscar, nombreCompleto: nombreCompleto)
                                        loginExitoso = true
                                    }else{
                                        notificacion = "Contraseña incorrecta"
                                        
                                    }
    
                                }
                            }else{
                                //respuestaUsuario = "Usuario NO Encontrado"
                                notificacion = "Usuario no encontrado"
                            }
                        }catch{
                            print(error)
                        }
                    }
                grupo.leave()
            }

            task.resume()
        
            grupo.wait()
            if notificacion != ""{
                alertas(titulo: "Aviso", texto: notificacion)
            }
            
            //lbRespuesta.text = respuestaUsuario
            return loginExitoso
    }
    
    func defineDefaults_Login( id : Int , email : String , nombreCompleto : String )->Void{
        defaults.setValue(id, forKey: "idUsuarios")
        defaults.setValue(email, forKey: "emailUsuarios")
        defaults.setValue(nombreCompleto, forKey: "nombreCompleto")
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


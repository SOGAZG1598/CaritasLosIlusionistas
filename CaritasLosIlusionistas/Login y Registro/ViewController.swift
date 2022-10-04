//
//  ViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit



//ESTE ES EL LOGIN
class ViewController: UIViewController {
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
        
        if emailusad.contains("@caritas.mx") && loginExitoso{
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
        
        // CHECA SI HAY ESPACIOS VACIOS
        if (lbEmail != nil && lbPass.text != ""){
            emailBuscar = lbEmail.text!
            contra = lbPass.text!
        }else{
            //emailBuscar.text = "hugo"
            print("Uno de los campos esta vacío")
            return loginExitoso
        }
        //INICIA API
        guard let url = URL(string:"https://equipo05.tc2007b.tec.mx:10210/usuarios/login?emailUsuarios=\(emailBuscar)")
        else { return loginExitoso }
        
         /*
           https://pokeapi.co/api/v2/pokemon/ditto
           https://shakira.tc2007b.tec.mx:10201/user?username=hugo
         */
            //var respuestaUsuario = ""
        
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
                                        nombreCompleto = "\(i.nombreUsuarios) \(i.apellidoPaterno) \(i.apellidoPaterno)"
                                        
                                        if(i.passUsuarios == contra){
                                            print("Login exitoso")
                                            //METAN TODOS LOS DATOS A DEFAULTS y activarle el segue
                                            self.defineDefaults_Login(id: idUsuario, email: emailBuscar, nombreCompleto: nombreCompleto)
                                            loginExitoso = true
                                        }else{
                                            print("Contraseña incorecta")
                                            
                                        }
                                        //respuestaUsuario = "USUARIO: Id = \(i.idUsers), Username: \(i.username), Password: \(i.password)"
                                    }
                                }else{
                                    //respuestaUsuario = "Usuario NO Encontrado"
                                    print("----- USUARIO NO ENCONTRADO -----")
                                }
                            }catch{
                                print(error)
                            }
                        }
                grupo.leave()
            }

            task.resume()
        
            grupo.wait()
            //lbRespuesta.text = respuestaUsuario
            return loginExitoso
    }
    
    func defineDefaults_Login( id : Int , email : String , nombreCompleto : String ){
        defaults.setValue(id, forKey: "idUsuarios")
        defaults.setValue(email, forKey: "emailUsuarios")
        defaults.setValue(nombreCompleto, forKey: "nombreCompleto")
    }
    
}


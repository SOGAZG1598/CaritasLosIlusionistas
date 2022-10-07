//
//  registroAdminViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit


class registroAdminViewController: UIViewController, UITextFieldDelegate {
    let defaults = UserDefaults.standard
    @IBOutlet weak var tfDepartamento: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func crearAdmin(_ sender: UIButton) {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    func lecturaTextFields() -> [String: Any]? {
        if let departamento = tfDepartamento.text , !departamento.isEmpty {
            alertas(titulo: "Felicidades admin", texto: "Estas completamente registrado")
            let matriculaAdmin = defaults.integer(forKey: "idUsuarios")
            let crearAdmin: [String: Any] = ["matriculaAdmin":matriculaAdmin, "departamento":departamento]
            return crearAdmin
        }else{
            alertas(titulo: "Aviso", texto: "Espacio vacío y/o incorrecto")
        }
        return nil
    }
    
    
    func API_RegistroPt2()->Int{
            //https://stackoverflow.com/a/60440711
            let crearAdmin = lecturaTextFields()
            if crearAdmin == nil {
                return -1
            }
            
            let jsonData = try? JSONSerialization.data(withJSONObject: crearAdmin)

            // create post request
            let url = URL(string: "https://equipo05.tc2007b.tec.mx:10210/admin/crear")! //PUT Your URL
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
                        if let responseJSON = responseJSON as? [String: Int] {
                            print(responseJSON) //Codigo
                        }
                        group.leave()
                    }
                    
                    task.resume()
                    group.wait()
                    return 0
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

}

//
//  registroUsuarioViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit

class registroVoluntarioViewController: UIViewController, UITextFieldDelegate {
    let defaults = UserDefaults.standard
    @IBOutlet weak var tfNombreDeLugar: UITextField!
    @IBOutlet weak var tfDomicilio: UITextField!
    
    //guarden sus variables fuera, aqui:
    var ocupacion: String = ""
    var cursoInduccion : Int = 0
    var escolaridad: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func crearVoluntario(_ sender: UIButton) {
        let i = API_RegistroPt2()
        if i != -1 {self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)}
    }
    
    @IBAction func sgCursoInduccion(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            cursoInduccion = 1
        } else {
            cursoInduccion = 0
        }
    }
    
    @IBAction func sgOcupacion(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            ocupacion = "Trabajo"
        }else if sender.selectedSegmentIndex == 1{
            ocupacion = "Estudio"
        }else {
            ocupacion = "Otro"
        }
    }
    
    @IBAction func sgEscolaridad(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            escolaridad = "Basica"
        }else if sender.selectedSegmentIndex == 1{
            escolaridad = "Superior"
        }else {
            escolaridad = "Media Superior"
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func lecturaTextFields() -> [String:Any]? {
        //let nombreDelLugar = tfNombreDeLugar.text!
        //let domicilio = tfDomicilio.text!
        if let nombreDelLugar = tfNombreDeLugar.text ,let domicilio = tfDomicilio.text, !nombreDelLugar.isEmpty, !domicilio.isEmpty {
            if nombreDelLugar.count < 48 || domicilio.count < 48 {
                
                alertas(titulo: "Felicidades", texto: "Estas completamente registrado")
                let matricula = defaults.integer(forKey: "idUsuarios")
                let crearVoluntario: [String: Any] = ["matricula":  matricula ,"cursoInduccion": cursoInduccion, "ocupacion": ocupacion, "lugarOcupacion": nombreDelLugar, "escolaridad": escolaridad, "domicilio": domicilio]
                
                return crearVoluntario
                
            }else{
                alertas(titulo: "Aviso", texto: "Campos mas largos de lo correspondido")
            }
            
        }else{
            alertas(titulo: "Aviso", texto: "Espacio vacío y/o incorrecto")
        }
        return nil
    }
    
    func API_RegistroPt2()->Int{
            //https://stackoverflow.com/a/60440711
            let crearVoluntario = lecturaTextFields()
            if crearVoluntario == nil {
                return -1
            }
            
            let jsonData = try? JSONSerialization.data(withJSONObject: crearVoluntario)

            // create post request
            let url = URL(string: "https://equipo05.tc2007b.tec.mx:10210/voluntarios/crear")! //PUT Your URL
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
                            print(responseJSON) //Code after Successfull POST Request
                            //verificador = responseJSON["matricula"]!
                            //print(verificador)
                            //self.defaults.setValue(verificador, forKey: "idUsuarios")
                            //self.setearDefault(idUsuario: verificador)
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

}

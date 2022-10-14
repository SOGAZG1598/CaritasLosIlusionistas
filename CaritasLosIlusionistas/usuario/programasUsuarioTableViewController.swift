//
//  programasUsuarioTableViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit

class programasUsuarioTableViewController: UITableViewController{
    
    let defaults = UserDefaults.standard
    
    var listaProgramasVol = [ProgramaVolElement]()

    @IBOutlet var programTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        programTableView.delegate = self
        self.title = "Programas"

        
        programTableView.delegate = self
        programTableView.dataSource = self
        programTableView.separatorStyle = .none
        programTableView.showsVerticalScrollIndicator = false
        
        llamadaAPI_Login()
        
    }

    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listaProgramasVol.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = programTableView.dequeueReusableCell(withIdentifier: "programCell", for: indexPath) as! ProgramasTVC
        let programaY = listaProgramasVol[indexPath.row]
        
        cell.programLbl.text = String(programaY.nombrePrograma)
        cell.fechaInicio.text = String(programaY.fechaInicio)
        cell.fechaFin.text = String(programaY.fechaFin)
        cell.adminLbl.text = String(programaY.nombreAdmin)
        cell.programasImgView.image = UIImage(named: programaY.nombrePrograma)

        
        //Make cell look good
        
        
        cell.programasView.layer.cornerRadius = cell.programasView.frame.height / 2
        cell.programasImgView.layer.cornerRadius = cell.programasImgView.frame.height / 2
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func llamadaAPI_Login(){
        var notificacion = ""
        let matricula = defaults.string(forKey: "idUsuarios")!
        guard let url = URL(string: "https://equipo05.tc2007b.tec.mx:10210/conexion/consultar?matricula=\(matricula)")
        else{ return }
        
        let group = DispatchGroup()
        group.enter()

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
                            let tasks = try decoder.decode([ProgramaVolElement].self, from: data)
                            if (!tasks.isEmpty){
                                tasks.forEach{ i in print("\(i.idPrograma)") }
                                print("Si hay datos!")
                            }else{
                                notificacion = "No hay programas asignados al admin"
                            }
                            
                            //manda a guardar los datos a la lista
                            self.listaProgramasVol = tasks
                        }catch{
                            print(error)
                        }
                    }
                group.leave()
            }

            task.resume()
        
            group.wait()
            if notificacion != ""{
                alertas(titulo: "Aviso", texto: notificacion)
            }
        programTableView.reloadData()
    }

    func alertas(titulo:String , texto:String) ->Void{
        let alerta = UIAlertController(title:titulo, message: texto, preferredStyle: .alert)
        let botonCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alerta.addAction(botonCancel)
        present(alerta, animated: true)
    }

    }







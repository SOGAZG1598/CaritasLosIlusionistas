//
//  listaProgramasAdminTableViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit

class programasAdminTableViewController: UITableViewController {
    let defaults = UserDefaults.standard
    
    var listaProgramasAdmin = [ProgramaElement]()
    @IBOutlet var programaAdminTableView: UITableView!
    
    var programasAdmin = ["Banco de Alimentos ✪", "Banco de Medicamentos ✪", "Cáritas Parroquiales ✪"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Programas"
        
        programaAdminTableView.delegate = self
        programaAdminTableView.dataSource = self
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //make look cool
        
        
        programaAdminTableView.separatorStyle = .none
        programaAdminTableView.showsVerticalScrollIndicator = false
        
        llamadaAPI_Login()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return programasAdmin.count
        return listaProgramasAdmin.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = programaAdminTableView.dequeueReusableCell(withIdentifier: "programasAdminCell", for: indexPath) as! ProgramasAdminTVC
        //let programas_Admin = programasAdmin[indexPath.row]
        let programaX = listaProgramasAdmin[indexPath.row]
        
        //cell.programasAdminLbl.text = programas_Admin
        //cell.programasAdminImgView.image = UIImage(named: programas_Admin)
        
        cell.programasAdminLbl.text = programaX.nombrePrograma
        //cell.programasAdminImgView.image = UIImage(named: programas_Admin)
        
        //make cell look good
        
        cell.programasAdminView.layer.cornerRadius = cell.programasAdminView.frame.height / 2
        cell.programasAdminImgView.layer.cornerRadius = cell.programasAdminImgView.frame.height / 2

        return cell
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    /*
    // Override to support editing the table view. ANADIR USUARIO DEPRECATED
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.beginUpdates()
            programasAdmin.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            tableView.beginUpdates()
            let vc = UIAlertController(title: "Agregar un programa", message: "Introduce un programa nuevo:", preferredStyle: .alert)
            vc.addTextField()
            
            let submitBtn = UIAlertAction(title: "Agregar", style: .default, handler: {_ in
                
                let textObj = vc.textFields![0]
                self.programasAdmin.insert(textObj.text!, at: indexPath.row)
                self.tableView.insertRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                
            })
            vc.addAction(submitBtn)
            present(vc, animated: true)
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
        let matriculaAdmin = defaults.string(forKey: "idUsuarios")!
        guard let url = URL(string: "https://equipo05.tc2007b.tec.mx:10210/programa/consultar?matriculaAdmin=\(matriculaAdmin)")
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
                            let tasks = try decoder.decode([ProgramaElement].self, from: data)
                            if (!tasks.isEmpty){
                                tasks.forEach{ i in print("\(i.nombrePrograma)") }
                                print("Si hay datos!")
                            }else{
                                notificacion = "No hay programas asignados al admin"
                            }
                            
                            //manda a guardar los datos a la lista
                            self.listaProgramasAdmin = tasks
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
        programaAdminTableView.reloadData()
    }
    
    func alertas(titulo:String , texto:String) ->Void{
        let alerta = UIAlertController(title:titulo, message: texto, preferredStyle: .alert)
        let botonCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alerta.addAction(botonCancel)
        present(alerta, animated: true)
    }

}

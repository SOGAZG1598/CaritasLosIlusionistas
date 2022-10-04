//
//  detalleProgramasAdminViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Carlos Valmaña Morales on 28/09/22.
//

import UIKit

class detalleProgramasAdminViewController: UIViewController {
    var voluntarios = ["Clark Kent", "Bruce Wayne", "Diana Prince", "Barry Allen", "Hal Jordan"]
    
    @IBOutlet weak var listaVolTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaVolTableView.delegate = self
        listaVolTableView.dataSource = self
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        listaVolTableView.showsVerticalScrollIndicator = false
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension detalleProgramasAdminViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) ->UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voluntarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listaVolTableView.dequeueReusableCell(withIdentifier: "listaCell") as! listaVoluntarioTVC
        let voluntario = voluntarios[indexPath.row]
        
        cell.volLbl.text = voluntario
        cell.volIMGView.image = UIImage(named: voluntario)
        
        cell.volIMGView.layer.cornerRadius = cell.volIMGView.frame.height / 2
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            voluntarios.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            tableView.beginUpdates()
            let vc = UIAlertController(title: "Agregar un voluntario", message: "Introduce un voluntario nuevo:", preferredStyle: .alert)
            vc.addTextField()
            
            let submitBtn = UIAlertAction(title: "Agregar", style: .default, handler: {_ in
                
                let textObj = vc.textFields![0]
                self.voluntarios.insert(textObj.text!, at: indexPath.row)
                tableView.insertRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                
            })
            vc.addAction(submitBtn)
            present(vc, animated: true)        }
    }
}

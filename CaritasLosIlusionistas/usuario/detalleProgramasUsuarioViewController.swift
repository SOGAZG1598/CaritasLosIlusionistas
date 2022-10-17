//
//  detalleProgramasUsuarioViewController.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 28/09/22.
//

import UIKit

class detalleProgramasUsuarioViewController: UIViewController {

    @IBOutlet weak var TimerLabel: UILabel!
    
    @IBOutlet weak var StartStopButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
        
    
    @IBAction func ResetAction(_ sender: Any) {
        let horasRegistrada = TimerLabel.text!
        let alert = UIAlertController(title: "Aviso", message: "Deseas terminar y registrar \(horasRegistrada) de asistencia?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCELAR", style: .cancel, handler: { (_) in
            //nada
        }))
        alert.addAction(UIAlertAction(title: "ACEPTAR", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func StartStopAction(_ sender: Any) {
        if(timerCounting)
        {
            //nada
        }
        else
        {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func timerCounter() -> Void
    {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    /*
    @IBAction func limpiarContador(_ sender: UIButton) {
        self.timerCounting=false
        self.timer.invalidate()
        self.TimerLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
    }*/
    
}

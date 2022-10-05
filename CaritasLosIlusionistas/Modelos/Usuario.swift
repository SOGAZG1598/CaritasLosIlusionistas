//
//  Usuario.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 03/10/22.
//

import Foundation

// MARK: - Usuario
struct Usuario: Codable {
    let idUsuarios: Int
    let nombreUsuarios, apellidoPaterno, apellidoMaterno, curpUsuarios: String
    let emailUsuarios, telefonoUsuarios, passUsuarios: String
    
    
    
    init(idUsuarios : Int, nombreUsuarios : String, apellidoPaterno :String, apellidoMaterno :String, curpUsuarios : String, emailUsuarios : String, telefonoUsuarios :String, passUsuarios :String){
        
        self.idUsuarios = idUsuarios
        self.nombreUsuarios = nombreUsuarios
        self.apellidoPaterno = apellidoPaterno
        self.apellidoMaterno = apellidoMaterno
        self.curpUsuarios = curpUsuarios
        self.emailUsuarios = emailUsuarios
        self.telefonoUsuarios = telefonoUsuarios
        self.passUsuarios = passUsuarios
    }
    
}


typealias Usuarios = [Usuario]

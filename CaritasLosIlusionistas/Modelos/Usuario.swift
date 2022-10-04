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
}

typealias Usuarios = [Usuario]

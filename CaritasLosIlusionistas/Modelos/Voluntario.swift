//
//  Voluntario.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 04/10/22.
//

import Foundation

// MARK: - Voluntario
struct Voluntario: Codable {
    let matricula, cursoInduccion: Int
    let ocupacion, lugarOcupacion, escolaridad, domicilio: String
}

typealias Voluntarios = [Voluntario]

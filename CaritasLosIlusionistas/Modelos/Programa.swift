//
//  Programa.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 11/10/22.
//

import Foundation

// MARK: - ProgramaElement
struct ProgramaElement: Codable {
    let descripcionHorario: String
    let idPrograma, matriculaAdmin: Int
    let nombrePrograma, tipo, ubicacion: String
}

typealias Programa = [ProgramaElement]


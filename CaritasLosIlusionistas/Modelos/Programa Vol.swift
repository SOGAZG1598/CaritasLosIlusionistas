//
//  Programa Vol.swift
//  CaritasLosIlusionistas
//
//  Created by Carlos Valmaña Morales on 13/10/22.
//

import Foundation

struct ProgramaVolElement: Codable {
    let fechaFin, fechaInicio: String
    let idPrograma, idVoluntarioPrograma, matricula: Int
}

typealias ProgramaVol = [ProgramaVolElement]

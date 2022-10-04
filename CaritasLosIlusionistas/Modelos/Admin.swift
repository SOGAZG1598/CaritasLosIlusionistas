//
//  Admin.swift
//  CaritasLosIlusionistas
//
//  Created by Sebastián Jaiovi on 04/10/22.
//

import Foundation

// MARK: - AdminElement
struct AdminElement: Codable {
    let matriculaAdmin: Int
    let departamento: String
}

typealias Admin = [AdminElement]

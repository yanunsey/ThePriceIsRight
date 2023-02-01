//
//  House.swift
//  ThePriceIsRight
//
//  Created by Yanunsey on 23/1/23.
//

import Foundation

let house = House()

class House: CustomStringConvertible {
    var rooms = 1
    var bathrooms = 1
    var garage = 0
    var year = 1975
    var size = 100
    var condition = 0

    
    var description: String {
        
        let star = "⭐️"
        var valoration = ""
        
        for _ in 0...condition {
            valoration = "\(valoration)\(star)"
        }
        return """
        - Número de habitaciones: \(rooms)
        - Número de baños: \(bathrooms)
        - Plazas de garaje: \(garage)
        - Año de construcción: \(year)
        - Superficie: \(size) \u{33A1}
        - Estado: \(valoration)
        """
    }

}

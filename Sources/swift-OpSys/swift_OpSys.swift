//
//  swift_OpSys.swift
//  swift-OpSys
//
//  Created by Alejandro D on 05/09/20.
//

import Foundation

// MARK: - Funciones Generales

extension String {

    func generaSubcadena (desde x : Int, hasta y : Int? = nil) -> String {
        let final : Int =  y == nil ? self.count : y!
        
        if x >= 0 && final > 0 && x < final && final <= self.count && x < self.count {
            let a : String = String(self[String.Index(utf16Offset: x, in: self)..<String.Index(utf16Offset: final, in: self)])
            return a
        }
        return ""
    }
    
    func obtenerCaracterEn (posicion i : Int) -> Character {
        if self.count > 0 && i > 0 && i <= self.count {
            return Character(self.generaSubcadena(desde: i-1, hasta: i))
        }
        return Character(" ")
    }
    
}

public struct Resultado {
    let cociente : String
    let residuo  : String
    
    func todoResultado() -> String {
        return "Cociente = \(cociente) - Residuo = \(residuo)"
    }
}


func emparejarNumeros(strNum1 : inout String, strNum2 : inout String) {
    var mayor = "1"
    
    if strNum2.count > strNum1.count {
        mayor = "2"
    }
    
    if mayor == "1" {
        while strNum1.count > strNum2.count {
            strNum2 = "0" + strNum2
        }
    } else {
        while strNum2.count > strNum1.count {
            strNum1 = "0" + strNum1
        }
    }
}

func eliminarCerosExtras(Resultado strR : inout String ) {
    while strR.count > 1 && strR[strR.startIndex] == "0" {
        strR.removeFirst()
    }
}

func analizarSignos(num1: inout String, num2 : inout String, esNegativo: inout Bool) {
    if num1.contains("-") && num2.contains("-") {
        esNegativo = false
        num1 = num1.replacingOccurrences(of: "-", with: "")
        num2 = num2.replacingOccurrences(of: "-", with: "")
    } else if num1.contains("-") && !num2.contains("-") {
        esNegativo = true
        num1 = num1.replacingOccurrences(of: "-", with: "")
    } else if !num1.contains("-") && num2.contains("-") {
        esNegativo = true
        num2 = num2.replacingOccurrences(of: "-", with: "")
    }
}

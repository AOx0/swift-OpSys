//
//  swift_OpSys.swift
//  swift-OpSys
//
//  Created by Alejandro D on 05/09/20.
//

import Foundation

// MARK: - Funciones Generales
/// Éste módulo contiene varias funciones recurrentes a lo largo del programa. Que ayudan a formatear variables.


extension String {
    
    /// Función que genera una cadena de caracteres iniciando desde el index inicial indicado hasta el index final indicado.
    /// Se accede a ésta por medio de sintaxis del punto en cualquier tipo de dato String.
    ///
    /// En el caso del parámetro "y", al no brindarse ningun index de final se genera una cadena desde el index inicial hasta el final del String.
    /// - Parameters:
    ///   - x: Integer con Index inicial
    ///   - y: Integer con Index final, opcional
    /// - Returns: String conteniendo la nueva cadena de caracteres desde el punto inicial hasta el punto final indicados
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

/// Estructura que sirve para devolver el resultado de divisiones a lo largo del programa.
/// Tiene 3 propiedades que contienen un residuo y un cociente junto con una propiedad que devuelve todo el resultado en un String.
///     - cociente: Contiene el cociente de la división
///     - residuo : Contiene el residuo de la dividión
///     - resultado : Contiene un String que informa el valor de cociente y residuo
public struct Resultado {
    public let cociente : String
    public let residuo  : String
    public lazy var resultado : String = {
        return "Cociente = \(cociente) - Residuo = \(residuo)"
    }()
    
}


/// Función privada.
/// Empareja el largo de dos cantidades contenidas en Strings agregando ceros a la izquierda para no modificarla, modifica directamente la variable pasada como parámetro. (apuntadores).
/// Ésto sirve para poder realizar las operaciones sin el riesgo de que exista un error de index al acceder a dos caracteres a multiplicar, sumar, restar, etc.
/// Ej:
///     var num1 = "1000"
///     var num2 = "1"
///     emparejarNumeros(strNum1: num1, strNum2: num2) - al terminar strNum1 es "1000" y strNum2 es "0001"
/// Es obligatorio pasar como parámetros variables.
///
/// - Parameters:
///   - strNum1: Apuntador a una variable String
///   - strNum2: Apuntador a una variable String
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

/// Funcicón Privada
/// Función que elimina todos los ceros a la izquiera que contenga una cantidad, si la cantidad es 0000 no elimina el último 0 para evitar crasheos. Modifica directamente la variable pasada como parámetro. (apuntador)
/// Muchas operacioes utilizan ésta función ya que por lo general terminan con uno o varios ceros a la izquierda.
///  Ej:
///      var num1 = "000000000000"
///      eliminarCerosExtras(Resultado: num1) - al final num1 es "0"
///
/// - Parameter strR: Apuntador a una variable String, lleva el nombre de resultado ya que para éstos se creó
func eliminarCerosExtras(Resultado strR : inout String ) {
    while strR.count > 1 && strR[strR.startIndex] == "0" {
        strR.removeFirst()
    }
}

/// Ley de Signos - función privada
/// Función que dependiendo los signos que contengan los miembros de una operación, analiza y dictamina qué tipo de resultado dará la misma, es decir, aplica la ley de signos.
/// Ej: -1 * -1 es igual a 1, pues la función se encarga de ésto.
/// - Parameters:
///   - num1: Cantidad númerica en cualquier base contenida en un String
///   - num2: Cantidad  númerica en cualquier base contenida en un String
///   - esNegativo: Apuntador a la variable "esNegativo", determina si al final de la operación el resultado se debe quedar positivo o negativo.
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

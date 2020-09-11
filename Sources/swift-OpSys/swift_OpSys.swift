//
//  swift_OpSys.swift
//  swift-OpSys
//
//  Created by Alejandro D on 05/09/20.
//

import Foundation

/// Éste módulo contiene varias funciones, estructuras y extensiones recurrentes a lo largo del programa. Que ayudan a formatear variables.


// MARK: - Extensiones String

extension String {
    
    /// Función que genera una cadena de caracteres iniciando desde el index inicial indicado hasta el index final indicado.
    /// Se accede a ésta por medio de sintaxis del punto en cualquier tipo de dato String.
    ///
    /// En el caso del parámetro "y", al no brindarse ningun index de final se genera una cadena desde el index inicial hasta el final del String.
    /// - Parameters:
    ///   - x: Integer con Index inicial
    ///   - y: Integer con Index final, opcional
    /// - Returns: String conteniendo la nueva cadena de caracteres desde el punto inicial hasta el punto final indicados
    func generaSubcadena (desde indexInicial : Int, hasta indexFinal : Int? = nil) -> String {
        let final : Int =  indexFinal == nil ? self.count : indexFinal!
        
        if indexInicial >= 0 && final > 0 && indexInicial < final && final <= self.count && indexInicial < self.count {
            let a : String = String(self[String.Index(utf16Offset: indexInicial, in: self)..<String.Index(utf16Offset: final, in: self)])
            return a
        }
        return ""
    }
    
    
    /// Devuelve el caracter en la posición indicada de un String.
    /// No tiene handling de error de index
    /// - Parameter i: index deseado
    /// - Returns: Caracter en la posición indicada
    func obtenerCaracterEn (posicion i : Int) -> Character {
        if self.count > 0 && i > 0 && i <= self.count {
            return Character(self.generaSubcadena(desde: i-1, hasta: i))
        }
        return Character(" ")
    }
    
}


// MARK: - Estructura Resultado

/// Estructura que sirve para devolver el resultado de divisiones a lo largo del programa.
/// Tiene 3 propiedades que contienen un residuo y un cociente junto con una propiedad que devuelve todo el resultado en un String.
///     - cociente: Contiene el cociente de la división
///     - residuo : Contiene el residuo de la dividión
///     - resultado : Contiene un String que informa el valor de cociente y residuo
public struct Resultado {
    public let cociente : String
    public let residuo  : String
    public let resultado : String
    
    public init(cociente: String, residuo: String) {
        self.cociente = cociente
        self.residuo = residuo
        self.resultado = "Cociente: \(cociente) - Residuo: \(residuo)"
    }
    
}

// MARK: - Funciones
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
func emparejarLongitud(de num1: inout String, y num2: inout String) {
    let mayor = num2.count > num1.count ? "2" : "1"
    
    if mayor == "1" {
        while num1.count > num2.count { num2 = "0" + num2 }
    } else {
        while num2.count > num1.count { num1 = "0" + num1 }
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
func eliminarCerosExtras(deCantidad cantidad : inout String ) {
    while cantidad.count > 1 && cantidad[cantidad.startIndex] == "0" {
        cantidad.removeFirst()
    }
}

/// Ley de Signos - función privada
/// Función que dependiendo los signos que contengan los miembros de una operación, analiza y dictamina qué tipo de resultado dará la misma, es decir, aplica la ley de signos.
/// Ej: -1 * -1 es igual a 1, pues la función se encarga de ésto.
/// - Parameters:
///   - num1: Cantidad númerica en cualquier base contenida en un String
///   - num2: Cantidad  númerica en cualquier base contenida en un String
///   - esNegativo: Apuntador a la variable "esNegativo", determina si al final de la operación el resultado se debe quedar positivo o negativo.
func resultadoLeySignos(num1: inout String, num2 : inout String, esNegativo: inout Bool) {
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

enum Errors : Error {
    case wrongDataType
}

func checkValidDataType<T>(_ variable : T) -> Bool {
    guard T.Type.self == String.Type.self || T.Type.self == Int.Type.self else {
        return false
    }
    return true
    
}

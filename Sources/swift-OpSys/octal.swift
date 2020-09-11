//
//  octal.swift
//  swift-OpSys
//
//  Created by Alejandro D on 05/09/20.
//

import Foundation

/// Éste módulo contiene las funciones que tienen que ver con operaciones con octales
// MARK: - Suma Octal

/// Función pública: Suma Octal
/// Recibe dos números en octal en forma de Strings y devuelve un String con el resultado de su suma
/// Ej: sumaOctal("7123", más: "1421") devuelve "10544"
///
/// - Parameters:
///   - num1: String que contiene un número octal que actúa como sumando
///   - num2: String que contiene un número octal que actúa como sumando
/// - Returns: String con el resultado de la suma total de la operación num1 + num2
public func sumaOctal<Octal>(_ num1 : Octal, más num2 : Octal ) -> String {
    guard checkValidDataType(num1) && checkValidDataType(num2) else { return "0" }
    
    var num1 = String(describing: num1),  num2 = String(describing: num2), resultado = "", llevo = 0, esSumaNegativos = false
    
    if num1.contains("-") && num2.contains("-") {
        esSumaNegativos = true
        num1 = num1.replacingOccurrences(of: "-", with: "")
        num2 = num2.replacingOccurrences(of: "-", with: "")
    } else if num1.contains("-") && !num2.contains("-") {
        num1 = num1.replacingOccurrences(of: "-", with: "")
        return restaOctal(num2, menos: num1)
    } else if !num1.contains("-") && num2.contains("-") {
        num2 = num2.replacingOccurrences(of: "-", with: "")
        return restaOctal(num1, menos: num2)
    }
    emparejarLongitud(de: &num1, y: &num2)
    
    for i in (0..<num1.count).reversed() {
        var rTemporal = Int(String(num1[String.Index(utf16Offset: i, in: num1)]))! + Int(String(num2[String.Index(utf16Offset: i, in: num2)]))!
        
        rTemporal += llevo
        llevo = rTemporal / 8
        rTemporal = rTemporal % 8
        resultado = String(rTemporal) + resultado
    }
    
    resultado = "\(llevo)" + resultado
    
    eliminarCerosExtras(deCantidad: &resultado )
    if esSumaNegativos { resultado = "-" + resultado }
    return resultado
    
}

// MARK: - Resta Octal

/// Función pública: Resta Octal
/// Recibe dos números en octal en forma de Strings y devuelve un String con el resultado de su resta (el primer parámetro menos el segundo)
/// Ej: restaOctal("7123", menos: "1421") devuelve "5502"
///
/// - Parameters:
///   - num1: String que contiene un número octal que actúa como minuendo
///   - num2: String que contiene un número octal que actúa como sustraendo
/// - Returns: String que contiene un número octal representando la diferencia de la operación num1 - num2
public func restaOctal<Octal>(_ num1 : Octal, menos num2 : Octal ) -> String {
    guard checkValidDataType(num1) && checkValidDataType(num2) else { return "0" }
    
    var num1 = String(describing: num1),  num2 = String(describing: num2), resultado = "", resto = 0
    
    if num1.contains("-") && num2.contains("-") {
        num1 = num1.replacingOccurrences(of: "-", with: "")
        num2 = num2.replacingOccurrences(of: "-", with: "")
        return restaOctal(num2, menos: num1)
    } else if num1.contains("-") && !num2.contains("-") {
        num2 = "-" + num2
        return sumaOctal(num1, más: num2)
    } else if !num1.contains("-") && num2.contains("-") {
        num2 = num2.replacingOccurrences(of: "-", with: "")
        return sumaOctal(num1, más: num2)
    }
    
    emparejarLongitud(de: &num1, y: &num2)
    
    for i in (0..<num1.count).reversed() {
        var rTemporal = Int(String(num1[String.Index(utf16Offset: i, in: num1)]))! - Int(String(num2[String.Index(utf16Offset: i, in: num2)]))!
        
        rTemporal -= resto
        let eraMenor = rTemporal < 0
        rTemporal += eraMenor ? 8 : 0
        
        resto = rTemporal / 8
        resto += eraMenor ? 1 : 0
        rTemporal = rTemporal % 8
        add(digito: rTemporal, aResultado: &resultado)
        
    }
    
    resultado = (resto != 0 ? "-\(restaOctal(num2, menos: num1))" : resultado)
    
    eliminarCerosExtras(deCantidad: &resultado )
    return resultado
}

// MARK: - Multiplicación Octal

/// Función Publica: Multiplicación Octal
/// Recibe dos números en octal en forma de Strings y devuelve un String con el producto de su multiplicación
/// Ej: multiOctal("7123", por: "1421") devuelve "12766203"
///
/// - Parameters:
///   - num1: String con un numero octal que actúa como factor
///   - num2: String con un numero octal que actúa como factor
/// - Returns: String con el producto de la multiplicación num1 * num2 en octal
public func multiOctal<Octal>(_ num1: Octal, por num2: Octal) -> String {
    guard checkValidDataType(num1) && checkValidDataType(num2) else { return "0" }
    
    var num1 = String(describing: num1), num2 = String(describing: num2), esNegativo = false
    
    func generarResultados(num1: String, num2 : String) -> [String] {
        
        func mulSimple (num1: String, num2 : String) -> String {
            let num = "0"+num1
            var rest = 0
            var result = ""
            var finalResult = ""
            if num.count >= num2.count {
                for x in num2.reversed() {
                    for y in num.reversed() {
                        result += String((Int(String(x))! * Int(String(y))!+rest) % 8)
                        rest =  (Int(String(x))! * Int(String(y))!+rest) / 8
                    }
                }
            }
            
            finalResult = String(result.reversed())
            
            
            if finalResult[String.Index(utf16Offset: 0, in: finalResult)] == "0" {
                finalResult.remove(at: finalResult.startIndex)
            }
            return finalResult
        }
        
        var resultsList : [String] = []
        for i in num2.reversed(){
            resultsList.append(mulSimple(num1: num1, num2: String(i)))
        }
        return resultsList
    }
    
    resultadoLeySignos(num1: &num1, num2: &num2, esNegativo: &esNegativo)
    emparejarLongitud(de: &num1, y: &num2)

    var zerosToAdd = ""
    var resultsWithZeros : [String] = []
    for result in generarResultados(num1: num1, num2: num2) {
        resultsWithZeros.append(result + zerosToAdd)
        zerosToAdd += "0"
        
    }
    var finalResult = "0"
    for i in resultsWithZeros {
        finalResult = sumaOctal(i, más: finalResult)
    }
    
    if esNegativo { finalResult = "-" + finalResult }
    return finalResult
}

// MARK: - Division Octal

/// Función publica : División Octal
/// Recibe dos números en octal en forma de Strings y devuelve un objeto de tipo Resultado con el cociente y residuo de su división (parametro 1 entre parametro 2)
/// Ej: diviOctal("7123", entre: "1421").cociente devuelve "4"
///   diviOctal("7123", entre: "1421").residuo devuelve "1017"
///   diviOctal("7123", entre: "1421").resultado devuelve "Cociente = 4 - Residuo = 1017"
///
/// - Parameters:
///   - numerador: String con un numero octal que actúa como numerador
///   - denominador: String con un numero octal que actúa como denominador
/// - Returns: Una instancia de la estructura Resultado que contiene en cociente y residuo en sus propiedades, resultado de numerador / denominador
public func diviOctal<Octal>(_ numerador: Octal, entre denominador: Octal) -> Resultado {
    guard checkValidDataType(numerador) && checkValidDataType(denominador) else { return Resultado(cociente: "0", residuo: "0") }
    
    var num1 = String(describing: numerador), num2 = String(describing: denominador), esNegativo = false
    var cociente = "0"
    var residuo = ""
   
    resultadoLeySignos(num1: &num1, num2: &num2, esNegativo: &esNegativo)

    eliminarCerosExtras(deCantidad: &num2)
    eliminarCerosExtras(deCantidad: &num1)
    
    if num2 == "0" {
         return Resultado(cociente: "Infinito", residuo: "0")
    } else if num1 == "0" {
         return Resultado(cociente: "0", residuo: "0")
    } else if Int(num1, radix:8)! < Int(num2, radix:8)! {
        return Resultado(cociente: "0", residuo: num1)
    } else {
        var fin : Int = num2.count
        cociente = ""
        residuo = fin <= num1.count ? num1.generaSubcadena(desde: 0 , hasta: num2.count) : ""
         
        while fin <= num1.count {
            if  Int(num2,radix:8)! <= Int(residuo,radix:8)! {
                let cocienteCalculado = calcularCociente(num2: num2, residuoOriginal: residuo)
                residuo = restaOctal(residuo, menos: multiOctal(num2, por: cocienteCalculado))
                eliminarCerosExtras(deCantidad: &residuo)
                cociente += cocienteCalculado
            } else {
                cociente = cociente + "0"
            }
            fin += 1
            if fin <= num1.count {
                residuo = residuo + String (num1.obtenerCaracterEn(posicion : fin))
                eliminarCerosExtras(deCantidad: &residuo)
            }
        }
    }
        
    eliminarCerosExtras(deCantidad: &cociente)
    eliminarCerosExtras(deCantidad: &residuo)
    if esNegativo { cociente = "-" + cociente }
    return Resultado(cociente: cociente, residuo: residuo)
}


/// Función privada clave para la división.
/// Calcula el cociente que tiene una división con un loop que analiza cuántas veces cabe el denominador en el numerador, no devuelve el residuo.
/// - Parameters:
///   - num2: Denominador contenido en un String
///   - residuoOriginal: Numerador contenido en un String
/// - Returns: El número de veces que cabe el denominador en el numerador
func calcularCociente(num2: String, residuoOriginal: String) -> String {
    var residuo = "", num2 = num2, cociente = 0
    repeat {
        cociente += 1
        residuo = restaOctal(residuoOriginal, menos: multiOctal(num2, por: String(cociente)))
        eliminarCerosExtras(deCantidad: &residuo)
    } while Int(residuo,radix:8)! >= Int(num2,radix:8)!
    
    return "\(cociente)"
}

//
//  hexa.swift
//  swift-OpSys
//
//  Created by Alejandro D on 05/09/20.
//

import Foundation

/// Éste módulo contiene las funciones que tienen que ver con operaciones con hexadecimales
// MARK: - Suma Hexadecimal

/// Función pública: Suma Hexadecimal
/// Recibe dos números en hexadecimal en forma de Strings y devuelve un String con el resultado de su suma
/// Ej: sumaHex("A51F9", más: "FFF") devuelve "A61F8"
///
/// - Parameters:
///   - num1: String que contiene un número hexadecimal que actúa como sumando
///   - num2: String que contiene un número hexadecimal que actúa como sumando
/// - Returns: String con el resultado de la suma total de la operación num1 + num2
public func sumaHex(_ num1 : String, más num2 : String ) -> String {
    var num1 = num1,  num2 = num2, resultado = "", llevo = 0, esSumaNegativos = false
    
    if num1.contains("-") && num2.contains("-") {
        esSumaNegativos = true
        num1 = num1.replacingOccurrences(of: "-", with: "")
        num2 = num2.replacingOccurrences(of: "-", with: "")
    } else if num1.contains("-") && !num2.contains("-") {
        num1 = num1.replacingOccurrences(of: "-", with: "")
        return restaHex(num2, menos: num1)
    } else if !num1.contains("-") && num2.contains("-") {
        num2 = num2.replacingOccurrences(of: "-", with: "")
        return restaHex(num1, menos: num2)
    }
    emparejarNumeros(strNum1: &num1, strNum2: &num2)
    
    let num1List = obtenerListaDigitos(variable: num1)
    let num2List = obtenerListaDigitos(variable: num2)
    
    for i in (0..<num1.count).reversed() {
        var rTemporal = num1List[i] + num2List[i]
        //var rTemporal = Int(String(num1[String.Index(utf16Offset: i, in: num1)]))! + Int(String(num2[String.Index(utf16Offset: i, in: num2)]))!
        
        rTemporal += llevo
        llevo = rTemporal / 16
        rTemporal = rTemporal % 16
        add(digito: rTemporal, aResultado: &resultado)
    }
    
    resultado = "\(llevo)" + resultado
    
    eliminarCerosExtras(Resultado: &resultado )
    if esSumaNegativos { resultado = "-" + resultado }
    return resultado
    
}

// MARK: - Resta Hexadecimal

/// Función pública: Resta Hexadecimal
/// Recibe dos números en hexadecimal en forma de Strings y devuelve un String con el resultado de su resta (el primer parámetro menos el segundo)
/// Ej: restaHex("A51F9", menos: "FFF") devuelve "A41FA"
///
/// - Parameters:
///   - num1: String que contiene un número hexadecimal que actúa como minuendo
///   - num2: String que contiene un número hexadecimal que actúa como sustraendo
/// - Returns: String que contiene un número hexadecimal representando la diferencia de la operación num1 - num2
public func restaHex(_ num1 : String, menos num2 : String ) -> String {
    var num1 = num1,  num2 = num2, resultado = "", resto = 0
    
    if num1.contains("-") && num2.contains("-") {
        num1 = num1.replacingOccurrences(of: "-", with: "")
        num2 = num2.replacingOccurrences(of: "-", with: "")
        return restaHex(num2, menos: num1)
    } else if num1.contains("-") && !num2.contains("-") {
        num2 = "-" + num2
        return sumaHex(num1, más: num2)
    } else if !num1.contains("-") && num2.contains("-") {
        num2 = num2.replacingOccurrences(of: "-", with: "")
        return sumaHex(num1, más: num2)
    }
    
    emparejarNumeros(strNum1: &num1, strNum2: &num2)
    
    let num1List = obtenerListaDigitos(variable: num1) //124F [1,2,4,15]
    let num2List = obtenerListaDigitos(variable: num2)
    
    for i in (0..<num1.count).reversed() {
        var rTemporal = num1List[i] - num2List[i]
        
        rTemporal -= resto
        let eraMenor = rTemporal < 0
        rTemporal += eraMenor ? 16 : 0
        
        resto = rTemporal / 16
        resto += eraMenor ? 1 : 0
        rTemporal = rTemporal % 16
        add(digito: rTemporal, aResultado: &resultado)
        
    }
    
    resultado = (resto != 0 ? "-\(restaHex(num2, menos: num1))" : resultado)
    
    eliminarCerosExtras(Resultado: &resultado )
    return resultado
}

// MARK: - Multiplicación Hexadecimal

/// Función Publica: Multiplicación Hexadecimal
/// Recibe dos números en hexadecimal en forma de Strings y devuelve un String con el producto de su multiplicación
/// Ej: multiHex("A51F9", por: "FFF") devuelve "A5153E07"
///
/// - Parameters:
///   - num1: String con un numero hexadecimal que actúa como factor
///   - num2: String con un numero hexadecimal que actúa como factor
/// - Returns: String con el producto de la multiplicación num1 * num2 en hexadecimal
public func multiHex(_ num1: String, por num2: String) -> String {
    var num1 = num1, num2 = num2, esNegativo = false
    
    func generarResultados(num1: String, num2 : String) -> [String] {
        
        func mulSimple (num1: String, num2 : String) -> String {
            let num = "0"+num1
            var rest = 0
            var result = ""
            var finalResult = ""
            if num.count >= num2.count {
                for x in num2.reversed() {
                    for y in num.reversed() {
                        let digito = Int((getDecimal(digito: x) * getDecimal(digito: y) + rest) % 16)
                        result += getHex(digito: digito)
                        rest =  (getDecimal(digito: x) * getDecimal(digito: y) + rest) / 16
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
    
    var listWithResults : [String] = []
    
    analizarSignos(num1: &num1, num2: &num2, esNegativo: &esNegativo)
    
    emparejarNumeros(strNum1: &num1, strNum2: &num2)
    
    
    listWithResults = generarResultados(num1: num1, num2: num2)
    

    var zerosToAdd = ""
    var resultsWithZeros : [String] = []
    for result in listWithResults {
        resultsWithZeros.append(result + zerosToAdd)
        zerosToAdd += "0"
        
    }
    var finalResult = "0"
    for i in resultsWithZeros {
        finalResult = sumaHex(i, más: finalResult)
    }
    
    if esNegativo { finalResult = "-" + finalResult }
    return finalResult
}

// MARK: - Division Hexadecimal

/// Función publica : División Hexadecimal
/// Recibe dos números en hexadecimal en forma de Strings y devuelve un objeto de tipo Resultado con el cociente y residuo de su división (parametro 1 entre parametro 2)
/// Ej: diviHex("A5153E07", entre: "FFF").cociente devuelve "A51F9"
///   diviHex("A5153E07", entre: "FFF").residuo devuelve "0"
///   diviHex("A5153E07", entre: "FFF").resultado devuelve "Cociente = A51F9 - Residuo = "0"
///
/// - Parameters:
///   - numerador: String con un numero hexadecimal que actúa como numerador
///   - denominador: String con un numero hexadecimal que actúa como denominador
/// - Returns: Una instancia de la estructura Resultado que contiene en cociente y residuo en sus propiedades, resultado de numerador / denominador
public func diviHex(_ numerador: String, entre denominador: String) -> Resultado {
    var num1 = numerador, num2 = denominador, esNegativo = false
    var cociente = "0"
    var residuoHex = ""

    analizarSignos(num1: &num1, num2: &num2, esNegativo: &esNegativo)

    eliminarCerosExtras(Resultado: &num2)
    eliminarCerosExtras(Resultado: &num1)
    
    if num2 == "0" {
         return Resultado(cociente: "Infinito", residuo: "0")
    } else if num1 == "0" {
         return Resultado(cociente: "0", residuo: "0")
    } else if Int(num1, radix:16)! < Int(num2, radix:16)! {
        return Resultado(cociente: "0", residuo: num1)
    } else {
        var fin : Int = num2.count
        cociente = ""
        residuoHex = fin <= num1.count ? num1.generaSubcadena(desde: 0 , hasta: num2.count) : ""
        
        while fin <= num1.count {
            if  Int(num2,radix:16)! <= Int(residuoHex,radix:16)! {
                let cocienteCalculado = calcularCocienteHex(num2: num2, residuoOriginal: residuoHex)
                residuoHex = restaHex(residuoHex, menos: multiHex(num2, por: cocienteCalculado))
                eliminarCerosExtras(Resultado: &residuoHex)
                cociente += cocienteCalculado
            } else {
                cociente = cociente + "0"
            }
            fin += 1
            if fin <= num1.count {
                residuoHex = residuoHex + String (num1.obtenerCaracterEn(posicion : fin))
                eliminarCerosExtras(Resultado: &residuoHex)
            }
        }
    }
        
    eliminarCerosExtras(Resultado: &cociente)
    eliminarCerosExtras(Resultado: &residuoHex)
    if esNegativo { cociente = "-" + cociente }
    return Resultado(cociente: cociente, residuo: residuoHex)
}

private func calcularCocienteHex(num2: String, residuoOriginal: String) -> String {
    var residuo = "", num2 = num2, cociente = 0
    repeat {
        cociente += 1
        residuo = restaHex(residuoOriginal, menos: multiHex(num2, por: getHex(digito: cociente)))
        eliminarCerosExtras(Resultado: &residuo)
    } while Int(residuo,radix:16)! >= Int(num2,radix:16)!
    
    
    return getHex(digito: cociente)
}


/// Éste modulo contiene distintas funciones recurrentes necesarias para realizar las opercioens entre Hexadecimales
// MARK: - Funciones Hexadecimal


/// Función privada.
/// Devuelve una lista remplazando todos los dígitos que representan números iguales o mayores a 10 del sistema Hexadecimal de un String
/// Ej: obtenerListaDigitos(variable: "1AF78") devuelve [1, 10, 15, 7, 8]
///
/// - Parameter variable: String que contiene un número hexadecimal
/// - Returns: Lista de Integers con el número hexadecimal de "variable"
func obtenerListaDigitos(variable: String) -> [Int] {
    var listaResultados : [Int] = []
    for digit in variable {
        switch digit {
        case "A": listaResultados.append(10)
        case "B": listaResultados.append(11)
        case "C": listaResultados.append(12)
        case "D": listaResultados.append(13)
        case "E": listaResultados.append(14)
        case "F": listaResultados.append(15)
        default:
            listaResultados.append(Int(String(digit))!)
        }
    }
    
    return listaResultados
}


/// Función privada
/// Convierte un Integer a Hexadecimal y lo concatena a una variable.
/// - Parameters:
///   - digito: Int representando un hexadecimal
///   - resultado: Variable de tipo String para concatenar el dígito convertido a Hexadecimal
func add(digito: Int, aResultado resultado: inout String) {
    switch digito {
    case 10: resultado = String("A") + resultado
    case 11: resultado = String("B") + resultado
    case 12: resultado = String("C") + resultado
    case 13: resultado = String("D") + resultado
    case 14: resultado = String("E") + resultado
    case 15: resultado = String("F") + resultado
    default:
        resultado = String(digito) + resultado
    }
}

/// Función privada
/// Convierte un Character de un número Hexadecimal a un Int representando la misma cantidad
/// Ej: getDecimal(digito: "A") devuelve 10
///
/// - Parameter digito: Character que contiene un dígito en hexadecimal
/// - Returns: Integer representando en decimal el caracter que se pasa como parámetro
func getDecimal(digito: Character) -> Int {
    switch digito {
    case "A": return 10
    case "B": return 11
    case "C": return 12
    case "D": return 13
    case "E": return 14
    case "F": return 15
    default:
        return Int(String(digito))!
    }
}


/// Función privada
/// Convierte un Integer representando un dígito Hexadecimal en un String con el caracter Hexadecimal que le corresponde
/// Ej: getHex(digito: 10) devuelve "A"
///
/// - Parameter digito: El Integer representando un Hexadecimal
/// - Returns: Un String que contiene el digito ya convertido a Hexadecimal
func getHex(digito: Int) -> String {
    switch digito {
    case 10: return "A"
    case 11: return "B"
    case 12: return "C"
    case 13: return "D"
    case 14: return "E"
    case 15: return "F"
    default:
        return String(digito)
    }
}

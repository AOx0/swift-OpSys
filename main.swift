//
//  swift_OpSys.swift
//  swift-OpSys
//
//  Created by Alejandro D on 05/09/20.
//

import Foundation

func main() {
    /// Aquí escriba todo lo que desee probar
    
    // Ejemplos:
    print(diviBinarios("111", entre: "111").resultado)
    print(sumaHex("AAA", más: "ABC"))
}

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
    public let resultado : String
    
    public init(cociente: String, residuo: String) {
        self.cociente = cociente
        self.residuo = residuo
        self.resultado = "Cociente: \(cociente) - Residuo: \(residuo)"
    }
    
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

//
//  binario.swift
//  swift-OpSys
//
//  Created by Alejandro D on 06/09/20.
//



/// Éste módulo contiene las funciones que tienen que ver con operaciones con binarios
// MARK: - Suma Binarios


/// Función pública: Suma Binarios
/// Recibe dos números en binario en forma de Strings y devuelve un String con el resultado de su suma
/// Ej: sumaBinarios("10101", más: "1011") devuelve "100000"
///
/// - Parameters:
///   - num1: String que contiene un número binario que actúa como sumando
///   - num2: String que contiene un número binario que actúa como sumando
/// - Returns: String con el resultado de la suma total de la operación num1 + num2
public func sumaBinarios(_ num1 : String, más num2 : String ) -> String {
    var num1 = num1,  num2 = num2, resultado = "", llevoUno = false, esSumaNegativos = false
    
    if num1.contains("-") && num2.contains("-") {
        esSumaNegativos = true
        num1 = num1.replacingOccurrences(of: "-", with: "")
        num2 = num2.replacingOccurrences(of: "-", with: "")
    } else if num1.contains("-") && !num2.contains("-") {
        num1 = num1.replacingOccurrences(of: "-", with: "")
        return restaBinarios(num2, menos: num1)
    } else if !num1.contains("-") && num2.contains("-") {
        num2 = num2.replacingOccurrences(of: "-", with: "")
        return restaBinarios(num1, menos: num2)
    }
    emparejarNumeros(strNum1: &num1, strNum2: &num2)
    
    for i in (0..<num1.count).reversed() {
        var rTemporal = Int(String(num1[String.Index(utf16Offset: i, in: num1)]))! + Int(String(num2[String.Index(utf16Offset: i, in: num2)]))!
        
        rTemporal += (llevoUno ? 1 : 0)
        if rTemporal == 3 {
            rTemporal = 1
            llevoUno = true
            resultado = String(rTemporal) + resultado
        } else if rTemporal == 2 {
            rTemporal = 0
            llevoUno = true
            resultado = String(rTemporal) + resultado
        } else {
            llevoUno = false
            resultado = String(rTemporal) + resultado
        }
    }
    
    resultado = (llevoUno ? "1" : "") + resultado
    
    eliminarCerosExtras(Resultado: &resultado )
    if esSumaNegativos { resultado = "-" + resultado }
    return resultado
    
}

// MARK: - Resta Binarios

/// Función pública: Resta de Binarios
/// Recibe dos números en binario en forma de Strings y devuelve un String con el resultado de su resta (el primer parámetro menos el segundo)
/// Ej: restaBinarios("111010110111001", menos: "101011111") devuelve "111010001011010"
///
/// - Parameters:
///   - num1: String que contiene un número binario que actúa como minuendo
///   - num2: String que contiene un número binario que actúa como sustraendo
/// - Returns: String que contiene un número binario representando la diferencia de la operación num1 - num2
public func restaBinarios(_ num1 : String, menos num2 : String ) -> String {
    var num1 = num1,  num2 = num2, resultado = "", restoUno = false
    
    if num1.contains("-") && num2.contains("-") {
        num1 = num1.replacingOccurrences(of: "-", with: "")
        num2 = num2.replacingOccurrences(of: "-", with: "")
        return restaBinarios(num2, menos: num1)
    } else if num1.contains("-") && !num2.contains("-") {
        num2 = "-" + num2
        return sumaBinarios(num1, más: num2)
    } else if !num1.contains("-") && num2.contains("-") {
        num2 = num2.replacingOccurrences(of: "-", with: "")
        return sumaBinarios(num1, más: num2)
    }
    
    emparejarNumeros(strNum1: &num1, strNum2: &num2)
    
    for i in (0..<num1.count).reversed() {
        var rTemporal = Int(String(num1[String.Index(utf16Offset: i, in: num1)]))! - Int(String(num2[String.Index(utf16Offset: i, in: num2)]))!
        
        rTemporal -= (restoUno ? 1 : 0)
        if rTemporal == -2 {
            rTemporal = 0
            restoUno = true
            resultado = String(rTemporal) + resultado
        } else if rTemporal == -1 {
            rTemporal = 1
            restoUno = true
            resultado = String(rTemporal) + resultado
        } else {
            restoUno = false
            resultado = String(rTemporal) + resultado
        }
    }
    
    resultado = (restoUno ? "-\(restaBinarios(num2, menos: num1))" : resultado)
    
    eliminarCerosExtras(Resultado: &resultado )
    return resultado
}

// MARK: - Multiplicación Binarios

/// Función Publica: Multiplicación de Binarios
/// Recibe dos números en binario en forma de Strings y devuelve un String con el producto de su multiplicación
/// Ej: multiBinarios("111010110111001", por: "101011111") devuelve "101000010110100010100111"
///
/// - Parameters:
///   - num1: String con un numero binario que actúa como factor
///   - num2: String con un numero binario que actúa como factor
/// - Returns: String con el producto de la multiplicación num1 * num2 en binario
public func multiBinarios(_ num1: String, por num2: String) -> String {
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
                        result += String((Int(String(x))! * Int(String(y))!+rest) % 10)
                        rest =  (Int(String(x))! * Int(String(y))!+rest) / 10
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
        finalResult = sumaBinarios(i, más: finalResult)
    }
    
    if esNegativo { finalResult = "-" + finalResult }
    return finalResult
}

// MARK: - Division Binarios

/// Función publica : División de Binarios
/// Recibe dos números en binario en forma de Strings y devuelve un objeto de tipo Resultado con el cociente y residuo de su división (parametro 1 entre parametro 2)
/// Ej: diviBinarios("10101", entre: "10101").cociente devuelve "1"
///   diviBinarios("10101", entre: "10101").residuo devuelve "0"
///   diviBinarios("10101", entre: "10101").resultado devuelve "Cociente = 1 - Residuo = 0"
///
/// - Parameters:
///   - numerador: String con un numero binario que actúa como numerador
///   - denominador: String con un numero binario que actúa como denominador
/// - Returns: Una instancia de la estructura Resultado que contiene en cociente y residuo en sus propiedades, resultado de numerador / denominador
public func diviBinarios(_ numerador: String, entre denominador: String) -> Resultado {
    var num1 = numerador, num2 = denominador, esNegativo = false
    var cociente = "0"
    var residuo = ""

    analizarSignos(num1: &num1, num2: &num2, esNegativo: &esNegativo)

    eliminarCerosExtras(Resultado: &num2)
    eliminarCerosExtras(Resultado: &num1)
    
    if num2 == "0" {
         return Resultado(cociente: "Infinito", residuo: "0")
    } else if num1 == "0" {
         return Resultado(cociente: "0", residuo: "0")
    } else if Int(num1, radix: 2)! < Int(num2, radix: 2)! {
        return Resultado(cociente: "0", residuo: num1)
    } else {
        var fin : Int = num2.count
        cociente = ""
        residuo = fin <= num1.count ? num1.generaSubcadena(desde: 0 , hasta: num2.count) : ""
         
        while fin <= num1.count {
            if num2.count <= residuo.count && Int(num2,radix:2)! <= Int(residuo,radix:2)! {
                cociente = cociente + "1"
                residuo = restaBinarios(residuo, menos: multiBinarios(num2, por: "1"))
                eliminarCerosExtras(Resultado: &residuo)
            } else {
                cociente = cociente + "0"
            }
            fin += 1
            if fin <= num1.count {
                residuo = residuo + String (num1.obtenerCaracterEn(posicion : fin))
                eliminarCerosExtras(Resultado: &residuo)
            }
        }
    }
    
    eliminarCerosExtras(Resultado: &cociente)
    eliminarCerosExtras(Resultado: &residuo)
    if esNegativo { cociente = "-" + cociente }
    return Resultado(cociente: cociente, residuo: residuo)
}



//
//  hexa.swift
//  swift-OpSys
//
//  Created by Alejandro D on 05/09/20.
//



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
    
    let num1List = obtenerListaDigitos(variable: num1)
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
//
//  octal.swift
//  swift-OpSys
//
//  Created by Alejandro D on 05/09/20.
//



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
public func sumaOctal(_ num1 : String, más num2 : String ) -> String {
    var num1 = num1,  num2 = num2, resultado = "", llevo = 0, esSumaNegativos = false
    
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
    emparejarNumeros(strNum1: &num1, strNum2: &num2)
    
    for i in (0..<num1.count).reversed() {
        var rTemporal = Int(String(num1[String.Index(utf16Offset: i, in: num1)]))! + Int(String(num2[String.Index(utf16Offset: i, in: num2)]))!
        
        rTemporal += llevo
        llevo = rTemporal / 8
        rTemporal = rTemporal % 8
        resultado = String(rTemporal) + resultado
    }
    
    resultado = "\(llevo)" + resultado
    
    eliminarCerosExtras(Resultado: &resultado )
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
public func restaOctal(_ num1 : String, menos num2 : String ) -> String {
    var num1 = num1,  num2 = num2, resultado = "", resto = 0
    
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
    
    emparejarNumeros(strNum1: &num1, strNum2: &num2)
    
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
    
    eliminarCerosExtras(Resultado: &resultado )
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
public func multiOctal(_ num1: String, por num2: String) -> String {
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
public func diviOctal(_ numerador: String, entre denominador: String) -> Resultado {
    var num1 = numerador, num2 = denominador, esNegativo = false
    var cociente = "0"
    var residuo = ""
   
    analizarSignos(num1: &num1, num2: &num2, esNegativo: &esNegativo)

    eliminarCerosExtras(Resultado: &num2)
    eliminarCerosExtras(Resultado: &num1)
    
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
                eliminarCerosExtras(Resultado: &residuo)
                cociente += cocienteCalculado
            } else {
                cociente = cociente + "0"
            }
            fin += 1
            if fin <= num1.count {
                residuo = residuo + String (num1.obtenerCaracterEn(posicion : fin))
                eliminarCerosExtras(Resultado: &residuo)
            }
        }
    }
        
    eliminarCerosExtras(Resultado: &cociente)
    eliminarCerosExtras(Resultado: &residuo)
    if esNegativo { cociente = "-" + cociente }
    return Resultado(cociente: cociente, residuo: residuo)
}


func calcularCociente(num2: String, residuoOriginal: String) -> String {
    var residuo = "", num2 = num2, cociente = 0
    repeat {
        cociente += 1
        residuo = restaOctal(residuoOriginal, menos: multiOctal(num2, por: String(cociente)))
        eliminarCerosExtras(Resultado: &residuo)
    } while Int(residuo,radix:8)! >= Int(num2,radix:8)!
    
    return "\(cociente)"
}

main()

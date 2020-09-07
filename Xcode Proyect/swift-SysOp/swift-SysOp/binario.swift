//
//  binario.swift
//  swift-OpSys
//
//  Created by Alejandro D on 06/09/20.
//

import Foundation

func eliminarCerosExtras(Resultado strR : inout String ) {
    while strR.count > 1 && strR[strR.startIndex] == "0" {
        strR.removeFirst()
    }
}

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

func sumaBinarios(_ num1 : String, más num2 : String ) -> String {
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

func restaBinarios(_ num1 : String, menos num2 : String ) -> String {
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

func multiBinarios(_ num1: String, por num2: String) -> String {
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


func diviBinarios(_ numerador: String, entre denominador: String) -> Resultado {
    var num1 = numerador, num2 = denominador, esNegativo = false
    var cociente = "0"
    var residuo = ""

   
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
        
    if esNegativo { cociente = "-" + cociente }
    return Resultado(cociente: cociente, residuo: residuo)
}

struct Resultado {
    let cociente : String
    let residuo  : String
    
    func todoResultado() -> String {
        return "Cociente = \(cociente) - Residuo = \(residuo)"
    }
}



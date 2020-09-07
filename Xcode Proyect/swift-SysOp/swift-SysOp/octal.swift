//
//  Octal.swift
//  swift-OpSys
//
//  Created by Alejandro D on 05/09/20.
//

import Foundation

func sumaOctal(_ num1 : String, más num2 : String ) -> String {
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

func restaOctal(_ num1 : String, menos num2 : String ) -> String {
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

func multiOctal(_ num1: String, por num2: String) -> String {
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
        finalResult = sumaOctal(i, más: finalResult)
    }
    
    if esNegativo { finalResult = "-" + finalResult }
    return finalResult
}

func diviOctal(_ numerador: String, entre denominador: String) -> Resultado {
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
    } else if Int(num1, radix:8)! < Int(num2, radix:8)! {
        return Resultado(cociente: "0", residuo: num1)
    } else {
        var fin : Int = num2.count
        cociente = ""
        residuo = fin <= num1.count ? num1.generaSubcadena(desde: 0 , hasta: num2.count) : ""
         
        while fin <= num1.count {
            if  Int(num2,radix:8)! <= Int(residuo,radix:8)! {
                let cocienteCalculado = calcularCociente(num2: num2, residuoOriginal: residuo)
//                print("Residuo ", residuo, "(\(residuo)-\(multiOctal(num2, por: cocienteCalculado)))")
                residuo = restaOctal(residuo, menos: multiOctal(num2, por: cocienteCalculado))
                eliminarCerosExtras(Resultado: &residuo)
//                print("Residuo despúes de resta: ", residuo, "(\(residuo)-\(multiOctal(num2, por: cocienteCalculado)))")
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

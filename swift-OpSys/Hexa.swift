//
//  Hexa.swift
//  swift-OpSys
//
//  Created by Alejandro D on 05/09/20.
//

import Foundation

func sumaHex(_ num1 : String, más num2 : String ) -> String {
    var num1 = num1,  num2 = num2, resultado = "", llevo = 0, esSumaNegativos = false
    
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

func restaHex(_ num1 : String, menos num2 : String ) -> String {
    var num1 = num1,  num2 = num2, resultado = "", resto = 0
    
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
    
    let num1List = obtenerListaDigitos(variable: num1)
    let num2List = obtenerListaDigitos(variable: num2)
    
    for i in (0..<num1.count).reversed() {
        var rTemporal = num1List[i] - num2List[i]
        
        rTemporal -= resto
        if rTemporal < 0 {
            rTemporal += 16
            resto = rTemporal / 16
            rTemporal = rTemporal % 16
            add(digito: rTemporal, aResultado: &resultado)
        } else {
            resto = rTemporal / 16
            rTemporal = rTemporal % 16
            add(digito: rTemporal, aResultado: &resultado)
        }
        
    }
    
    resultado = (resto != 0 ? "-\(restaBinarios(num2, menos: num1))" : resultado)
    
    eliminarCerosExtras(Resultado: &resultado )
    return resultado
}

func multiHex(_ num1: String, por num2: String) -> String {
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
        finalResult = sumaHex(i, más: finalResult)
    }
    
    if esNegativo { finalResult = "-" + finalResult }
    return finalResult
}

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

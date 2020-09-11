# OpSys



El **código completo**: [main.swift](https://github.com/AOx0/swift-OpSys/blob/master/main.swift) (puede no estar actualizado a la ultima versión)



Paquete: 

-   Código para **Octal**: Sources / swift-OpSys / [octal.swift](https://github.com/AOx0/swift-OpSys/blob/master/Sources/swift-OpSys/octal.swift)
-   Código para **Binario**: Sources / swift-OpSys / [binario.swift](https://github.com/AOx0/swift-OpSys/blob/master/Sources/swift-OpSys/binario.swift)

-   Código para **Hex**: Sources / swift-OpSys / [hexa.swift](https://github.com/AOx0/swift-OpSys/blob/master/Sources/swift-OpSys/hexa.swift)

-   Funciones extra: Sources / swift-OpSys / [swift_OpSys.swift](https://github.com/AOx0/swift-OpSys/blob/master/Sources/swift-OpSys/swift_OpSys.swift)




-   **Tests**: Tests / swift-OpSysTests / [swift_OpSysTests.swift](https://github.com/AOx0/swift-OpSys/blob/master/Tests/swift-OpSysTests/swift_OpSysTests.swift)



## Descripción 

El programa es capaz de realizar sumas, restas, multiplicaciones y divisiones con los sistemas de numeración binario, octal y hexadecimal.



Cada función acepta como parámetros datos de tipo `Int`  y `String` . Excepto las del sistema hexadecimal que solo acepta `String` como parámetro. Todas funciones devuelven un String con el resultado, en caso de haber un error devuelve `"0"`.

```swift
sumaOctal("777", más: "1") 	// Devuelve "1000"
sumaOctal(777, más: 1)			// Devuelve "1000"

sumaOctal(77.7, más: 1)			// Error, devuelve "0"
```

```swift
sumaBinarios("10101", más: "1011")	// Devuelve "100000"
sumaBinarios(10101, más: 1011)	// Devuelve "100000"

sumaBinarios(10,101, más: 1011)		 // Error, devuelve "0"
```

```swift
sumaHex("A51F9", más: "FFF")	// Devuelve "A61F8"
sumaHex(12331, más: 832)			// Error del compilador, sumaHex recibe como parámetros datos de tipo String
```


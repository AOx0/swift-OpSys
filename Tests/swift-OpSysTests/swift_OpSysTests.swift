import XCTest
@testable import swift_OpSys

final class swift_OpSysTests: XCTestCase {
    
    // MARK: - Tests Binarios
    func testSumaBinarios() {
        XCTAssertEqual(sumaBinarios("10101", más: "1011"), "100000")
        XCTAssertEqual(sumaBinarios("-10101", más: "-1011"), "-100000")
        XCTAssertEqual(sumaBinarios("111010110111001", más: "101011111"), "111011100011000")
        
        XCTAssertEqual(sumaBinarios(10101, más: 1011), "100000")
        XCTAssertEqual(sumaBinarios(-10101, más: -1011), "-100000")
        XCTAssertEqual(sumaBinarios(111010110111001, más: 101011111), "111011100011000")
    }
    
    func testRestaBinarios() {
        XCTAssertEqual(restaBinarios("1011", menos: "10101"), "-1010")
        XCTAssertEqual(restaBinarios("10101", menos: "1011"), "1010")
        XCTAssertEqual(restaBinarios("111010110111001", menos: "101011111"), "111010001011010")
        
        XCTAssertEqual(restaBinarios(1011, menos: 10101), "-1010")
        XCTAssertEqual(restaBinarios(10101, menos: 1011), "1010")
        XCTAssertEqual(restaBinarios(111010110111001, menos: 101011111), "111010001011010")
    }
    
    func testMultiBinarios() {
        XCTAssertEqual(multiBinarios("1011", por: "10101"), "11100111")
        XCTAssertEqual(multiBinarios("10101", por: "1011"), "11100111")
        XCTAssertEqual(multiBinarios("111010110111001", por: "101011111"), "101000010110100010100111")
        
        XCTAssertEqual(multiBinarios(1011, por: 10101), "11100111")
        XCTAssertEqual(multiBinarios(10101, por: 1011), "11100111")
        XCTAssertEqual(multiBinarios(111010110111001, por: 101011111), "101000010110100010100111")
    }
    
    func testDivBinarios() {
        XCTAssertEqual(diviBinarios("1011", entre: "10101").cociente, "0")
        XCTAssertEqual(diviBinarios("10101", entre: "1011").cociente, "1")
        XCTAssertEqual(diviBinarios("111010110111001", entre: "101011111").cociente, "1010101")
        
        XCTAssertEqual(diviBinarios(1011, entre: 10101).cociente, "0")
        XCTAssertEqual(diviBinarios(10101, entre: 1011).cociente, "1")
        XCTAssertEqual(diviBinarios(111010110111001, entre: 101011111).cociente, "1010101")
    }
    
    // MARK: - Tests Octal
    func testSumaOctales() {
        XCTAssertEqual(sumaOctal("7123", más: "1421"), "10544")
        XCTAssertEqual(sumaOctal("7123", más: "-1421"), "5502")
        XCTAssertEqual(sumaOctal("777", más: "1"), "1000")
        
        XCTAssertEqual(sumaOctal(7123, más: 1421), "10544")
        XCTAssertEqual(sumaOctal(7123, más: -1421), "5502")
        XCTAssertEqual(sumaOctal(777, más: 1), "1000")
    }
    
    func testRestaOctales() {
        XCTAssertEqual(restaOctal("7123", menos: "1421"), "5502")
        XCTAssertEqual(restaOctal("7123", menos: "-1421"), "10544")
        XCTAssertEqual(restaOctal("777", menos: "1"), "776")
        
        XCTAssertEqual(restaOctal(7123, menos: 1421), "5502")
        XCTAssertEqual(restaOctal(7123, menos: -1421), "10544")
        XCTAssertEqual(restaOctal(777, menos: 1), "776")
    }
    
    func testMultiOctales() {
        XCTAssertEqual(multiOctal("7123", por: "1421"), "12766203")
        XCTAssertEqual(multiOctal("7123", por: "-1421"), "-12766203")
        XCTAssertEqual(multiOctal("777", por: "1"), "777")
        
        XCTAssertEqual(multiOctal(7123, por: 1421), "12766203")
        XCTAssertEqual(multiOctal(7123, por: -1421), "-12766203")
        XCTAssertEqual(multiOctal(777, por: 1), "777")
    }
    
    func testDivOctales() {
        XCTAssertEqual(diviOctal("7123", entre: "1421").cociente, "4")
        XCTAssertEqual(diviOctal("7123", entre: "-1421").cociente, "-4")
        XCTAssertEqual(diviOctal("777", entre: "1").cociente, "777")
        
        XCTAssertEqual(diviOctal(7123, entre: 1421).cociente, "4")
        XCTAssertEqual(diviOctal(7123, entre: -1421).cociente, "-4")
        XCTAssertEqual(diviOctal(777, entre: 1).cociente, "777")
    }
    
    // MARK: - Tests Hex
    func testSumaHex() {
        XCTAssertEqual(sumaHex("A51F9", más: "FFF"), "A61F8")
        XCTAssertEqual(sumaHex("-A51F9", más: "-FFF"), "-A61F8")
        XCTAssertEqual(sumaHex("A51F9", más: "-FFF"), "A41FA")
    }
    
    func testRestaHex() {
        XCTAssertEqual(restaHex("A51F9", menos: "FFF"), "A41FA")
        XCTAssertEqual(restaHex("-A51F9", menos: "-FFF"), "-A41FA")
        XCTAssertEqual(restaHex("A51F9", menos: "-FFF"), "A61F8")
    }
    
    func testMultiHex() {
        XCTAssertEqual(multiHex("A51F9", por: "FFF"), "A5153E07")
        XCTAssertEqual(multiHex("-A51F9", por: "-FFF"), "A5153E07")
        XCTAssertEqual(multiHex("A51F9", por: "-FFF"), "-A5153E07")
    }
    
    func testDivHex() {
        XCTAssertEqual(diviHex("A5153E07", entre: "FFF").cociente, "A51F9")
        XCTAssertEqual(diviHex("A5153E07", entre: "FFF").residuo, "0")
        XCTAssertEqual(diviHex("A51F9", entre: "FFF").cociente, "A5")
        XCTAssertEqual(diviHex("A51F9", entre: "A5").cociente, "1003")
    }
    
    

    static var allTests = [
        ("Tests de Binarios", testSumaBinarios, testRestaBinarios, testMultiBinarios, testDivBinarios),
        ("Tests de Octales", testSumaOctales, testRestaOctales, testMultiOctales, testDivOctales),
        ("Tests de Hexadecimales", testSumaHex, testRestaHex, testMultiHex, testDivHex),
    ]
}

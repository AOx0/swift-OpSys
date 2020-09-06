

#if DEBUG

print("101010 entre: 0 " , diviBinarios("101010", entre: "0"))
print("0 entre: 101010 " , diviBinarios("0", entre: "101010"))
print("resta el mismo ",restaBinarios("10101", menos: "10101"))
print("el mismo",diviBinarios("10101", entre: "10101"))   // 101010
print("1 entre: 101010 " , diviBinarios("1", entre: "101010"))
print("101010 entre: 1 " , diviBinarios("101010", entre: "1"))
print("11100111 entre: 10101 " , diviBinarios("11100111", entre: "10101"))
print("11100111 entre: 1011 " , diviBinarios("11100111", entre: "1011"))
print("101010 entre: 10 " , diviBinarios("101010", entre: "10"))
print("10 entre: 101010 " , diviBinarios("10", entre: "101010"))
print("a-",diviBinarios("-11100111", entre: "10101"))
print("b-",diviBinarios("-11100111", entre: "-10101"))
print("c-",diviBinarios("11100111", entre: "-10101"))
print("d-",diviBinarios("11100111", entre: "10101"))   //1011
print("e-",diviBinarios("111010110111001", entre: "101011111"))   //1010101

print("DIVICIONES TERMINADAS")

print("a-",multiBinarios("-1011", por: "10101"))
print("b-",multiBinarios("-1011", por: "-10101"))
print("c-",multiBinarios("1011", por: "-10101"))
print("d-",multiBinarios("1011", por: "10101"))   //11100111
print("e-",multiBinarios("10", por: "10101"))   // 101010
print("f-",multiBinarios("0101011", por: "0101"))   // 11010111
print("g-",multiBinarios("0", por: "10101"))   // 0
print("h-",multiBinarios("0110010", por: "0"))   // 0
print("i-",multiBinarios("1", por: "10101"))   // 10101
print("i-",multiBinarios("1", por: "10101"))   // 10101
print("j-",multiBinarios("0110010", por: "1"))   // 110010
>>>>>>> 41a2bdc... Structure changes

print("MULTIPLICACIONES TERMINADAS")

print(restaBinarios("1011", menos: "10101"))
print(restaBinarios("-1011", menos: "10101"))
print(restaBinarios("-1011", menos: "-10101"))
print(restaBinarios("1011", menos: "-10101"))

print("RESTAS TERMINADAS")

print(sumaBinarios("10101", más: "1011"))
print(sumaBinarios("-10101", más: "1011"))
print(sumaBinarios("-10101", más: "-1011"))
print(sumaBinarios("10101", más: "-1011"))

print("SUMAS TERMINADAS")

#else

print(multiBinarios("1011", por: "10101"))

#endif

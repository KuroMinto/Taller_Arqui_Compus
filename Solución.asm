#SimuProc 1.4.2.0
JMP 020
#Datos para el primer ejercicio
# 001 - Numero 0
0
# 002 - Numero 30
11110
# 003 - Numeros pares
0
# 004 - Numeros impares
0
#Datos para el segundo ejercicio
# 005 - Numero 1
1
# 006 - Numero 2
10
# 007 - Numero 3
11
# 008 - Votos Numero 1
0
# 009 - Votos Numero 2
0
# 00A - Votos Numero 3
0
# 00B - Votos Nulos
0
# 00C - Mayor Votos
0
# 00D - Numero 75
1001011
# 00E - Numero 300
100101100

# 020 - Inicio del programa completo
#020
# Menu de Inicio del programa
MSG *****************MENU PRINCIPAL*****************
MSG [1] Ejercicio N°1
MSG [2] Ejercicio N°2
MSG [3] Salir
MSG *****************OPCION A ELEGIR****************
LDT Ingrese la opcion que desea
# Verificacion de opcion
# Opcion 1
CMP 005
JEQ 030
# Opcion 2
CMP 006
JEQ 050
# Opcion 3
CMP 007
JEQ 09A
# Si no es ninguno, salta error.
JMP 100
# 030 - Inicia ejercicio 1
#030
# Se inicializa el BX en 0, por precauciones.
MOV BX,001
LDT Ingrese un numero:
# Se compara si es 30, si es mayor se salta a el error en memoria 102
CMP 002
JMA 102
DIV 006
XAB
# Se compara el resto que fue puesto en AX con 0, permitiendo saber si es par o impar
CMP 001
# Si es diferente, salta a las instrucciones si el numero es impar
JNE 043
INC 003
# Se ingresa el valor de 003 en AX para mostrarlo en pantalla
LDA 003
EAP El numero de pares al momento es:
# Se ingresa el valor de 004 en AX para mostrarlo en pantalla
LDA 004
EAP El numero de impares al momento es:
# Se pregunta al usuario si quiere seguir ingresando numeros
LDT Desea agregar otro numero [1] SI | [2] NO?
# Si la respuesta es 1, salta a 030, volviendo a pedir otro numero
CMP 005
JEQ 030
# Si la respuesta es 2, salta a 020, permitiendo al usuario elegir otra opcion de ejercicio o salir.
CMP 006
JEQ 020
# Si no es ninguna, se salta al error de memoria 104
JMP 104
# Instrucciones si el numero es impar
INC 004
LDA 003
EAP El numero de pares al momento es:
LDA 004
EAP El numero de impares al momento es:
JMP 03D

# 050 - Inicio ejercicio 2
#050
# Asignacion de valores a los registros BX y CX, BX=Contador y CX=Iterador
MOV BX,001
MOV CX,00E
# Conteo de Votos
# Se verifica si el CX es 0
MOV AX,CX
CMP 001
JEQ 068
# Se empiezan a leer los datos y hacer las verificaciones
LDB 200
# Verifica si es la opcion 1
CMP 005
JEQ 05F
# Verifica si es la opcion 2
CMP 006
JEQ 062
# Verifica si es la opcion 3
CMP 007
JEQ 065
# Si no es ninguno, se considera nulo
INC 00B
INC BX
LOOP 052
# 05F - Si el voto es para el primer candidato
INC 008
INC BX
LOOP 052
# 062 - Si el voto es para el segundo candidato
INC 009
INC BX
LOOP 052
# 065 - Si el voto es para el tercer candidato
INC 00A
INC BX
LOOP 052
# 068 - Si ya no hay más votos por contar
# Se verirican los votos numeros nulos para saber si la votacion es valida o no
LDA 00B
CMP 00D
# Salta si la eleccion es valida
JME 06E
#Si las elecciones no son validas
EAP La cantidad de votos nulos es:
MSG Por ello, las elecciones no son validas.
JMP 020
#Si las elecciones SI son validas
EAP La cantidad de votos nulos es:
MSG Por ello, las elecciones son validas, procediendo...
# Verificaciones de cual es el mayor
LDA 008
CMP 009
#Si 008 es mayor a 009
JMA 07D
JME 07C
#Se compara si los 3 son iguales
CMP 00A
# Si dos valores son iguales
JMA 10A
# 00A es mayor
JME 081
# En el caso que todos sean iguales
JMP 106
# Instrucciones si SOLO 008 es mayor o menor a 00A
CMP 00A
JME 081
# Si 008 es mayor que todos
MOV 00C,008
JMP 083
# Instrucciones si 009 es mayor que 008
LDA 009
CMP 00A
JME 081
# Si 009 es mayor que todos
MOV 00C,009
JMP 083
# Instrucciones si 00A es mayor que todos
LDA 00A
MOV 00C,00A
#Mensajes finales
MSG *****************ELECCIONES*****************
#Se cargan la cantidad de votos de cada candidado para mostrarlas
LDA 008
EAP La cantidad de votos del [PRIMER] candidato es:
LDA 009
EAP La cantidad de votos del [SEGUNDO] candidato es:
LDA 00A
EAP La cantidad de votos del [TERCER] candidato es:
# Se verifica quien es el ganador, para poder desplegar mensajes personalizados
LDA 00C
CMP 008
JEQ 092
CMP 009
JEQ 095
# Aqui van los mensajes para el tercer candidato
MSG El ganador de las elecciones es el [TERCER] candidato.
MSG *****************ELECCIONES*****************
JMP 020
# SI el primer candidato es ganador
MSG El ganador de las elecciones es el [PRIMER] candidato.
MSG *****************ELECCIONES*****************
JMP 020
# Si el segundo candidato es ganador
MSG El ganador de las elecciones es el [SEGUNDO] candidato.
MSG *****************ELECCIONES*****************
JMP 020



# 09A - HLT del Programa
#09A
MSG Muchas gracias por usar el programa.
HLT


# 100 - Inicio de mensajes de error
#100
# Mensaje para error en menu principal, eleccion erronea
MSG Ha elegido una opcion incorrecta, vuelva a intentarlo
JMP 025
# 102 - Mensaje para error de numero en ejercicio 1
MSG Ha ingresado un numero mayor a 30, vuelva a intentarlo
JMP 030
# 104 - Mensaje para error de opcion en ejercicio 1
MSG Ha elegido una opcion incorrecta, vuelva a intentarlo
JMP 030
# 106 - Mensaje sobre todos los candidatos con los mismos votos
LDA 008
EAP Todos los candidatos tienen la misma cantidad de votos:
MSG Se necesita una segunda ronda para poder determinar al ganador.
JMP 020
# 10A - Mensaje sobre 2 candidatos mayores con los mismos votos
MSG Los candidados con mas votos tienen la misma cantidad.
MSG Se necesita una segunda ronda para poder determinar al ganador.
JMP 020


#200
# 200 - Inicio lista de votos
100
1
10
11
11
1
100
11
11
11
1
101
100
10
101
10
101
0
0
10
0
10
1
0
100
100
100
1
100
1
1
1
100
11
101
10
101
0
0
10
11
1
1
11
10
1
10
0
10
101
101
101
11
0
100
10
11
11
1
100
101
0
100
101
101
0
100
0
0
1
101
0
10
11
11
100
11
1
10
10
101
10
101
0
101
101
1
10
10
101
11
1
100
101
100
1
10
100
0
100
0
101
10
101
1
0
10
11
11
100
0
101
11
11
10
100
100
11
1
10
0
11
0
101
0
1
101
10
0
100
100
1
101
11
1
11
11
100
10
10
101
0
11
100
101
11
10
101
1
11
10
11
1
10
100
100
0
100
0
0
11
1
0
100
100
1
0
10
10
1
100
1
11
0
11
100
10
1
0
101
0
0
10
11
1
101
11
101
11
0
0
100
101
1
1
100
100
100
101
0
0
10
101
10
0
11
10
100
0
0
0
0
11
100
1
10
11
10
1
100
1
1
10
11
100
1
101
10
0
10
0
1
11
101
0
10
1
11
100
1
100
101
101
11
0
1
10
0
11
101
1
101
101
11
100
100
101
11
100
0
10
11
100
11
101
0
10
11
100
0
0
0
10
11
10
100
0
101
1
11
10
11
100
100
1
11
101
1
100
100
100
1
10
100
11
10
11
1
10
1

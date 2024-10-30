En este README, voy a empezar a explicar que reglas del ajedrez voy a implentar.

QUE PUEDE HACER EL PROGRAMA:

1º  El peón avanza únicamente un paso hacia delante, sin la posibilidad de moverse 
    en diagonal ni hacia atrás. A la hora de capturar una pieza contraria, lo hará 
    desplazándose en diagonal hacia delante, ocupando solo una casilla. Sin embargo, 
    no puede capturar en línea recta, ya sea hacia delante o hacia atrás, ni en 
    diagonal hacia atrás. Además, el peón no tiene la habilidad de saltar sobre 
    otras piezas en el tablero.

2º  El caballo se moverá en forma de L, es decir, dos casillas en una dirección
    y luego una casilla en otra dirección. Siendo capaz de saltar o pasar por 
    encima de otras piezas.

3º  El  alfil se moverá en diagonal, pudiendo desplazarse todas las casillas que 
    quiera, pero en diagonal. No puede saltar o pasar por encima de otras piezas.

4º  La torre se moverá en lineas verticales y horizontales, pudiendo desplazarse
    todas las casillas que quiera, pero en  línea recta. No puede saltar o pasar 
    por encima de otras piezas.

5º  La reina tendrá la misma movilidad que la torre y el  alfil, es decir, podrá
    moverse vertical, horizontal y diagonalmente.  No puede saltar o pasar por 
    encima de otras piezas.

6º  El  rey se moverá solo una casilla  en cualquier dirección, es decir, de forma
    horizontal, vertical,  o diagonal. No puede saltar o pasar por encima de otras
    piezas.

7º  Solo puede capturar piezas del color opuesto, respetando siempre estas limitaciones.

8º  Existen dos colores que son blanco y negro.

9º  Cada jugador tiene 16 piezas en el tablero, dos torres, dos alfiles, dos caballos,
    ocho peones, una reina y un rey.

//Personalizar cada ficha?
//Crear escenarios 

10º La posición de las  piezas en el tablero es la siguiente: 
    Las piezas del usario 1: blanco
    En la fila 1, la posición de las piezas es la siguiente: a1 = torre, b1 = caballo, 
    c1 = alfil, d1 = reina, e1 = rey, f1 = alfil, g1 = caballo, h1 = torre.

    En la fila 2,  la posición de las piezas es la siguiente: a2 = peón, b2 = peón,
    c3 = peón, d4 = peón, e5 = peón, f6 = peón,  g7 = peón, h8 = peón.

    Las piezas del usuario 2: negro
    En  la fila 8, la posición de las piezas es la siguiente: a8 = torre,  b8 = caballo, 
    c8 = alfil, d8 = reina, e8 = rey, f8 =  alfil, g8 = caballo, h8 = torre.

    En la fila 7,  la posición de las piezas es la siguiente: a7  = peón, b7 = peón,
    c7 = peón, d7 = peón, e7 = peón, f7 = peón, g7 =  peón, h7 = peón.

11º Siempre empieza a jugar el usario 1 o blanco. 

12º Cada usuario solo puede realizar un movimiento por turno, y cuando este lo realiza,
    el turno pasa al otro usuario.

13º Un usuario gana la partida si consigue Jaque Mate.

14º Si se da la situación en la que un usuario no puede realizar ningún movimiento,
    se considera que se ha dado  una situación de empate, debido a rey ahogado.

15º Las piezas pueden comerse entre ellas, de forma que si una pieza quiere ocupar, 
    una posición en concreto, y en esa casilla se encuentra una pieza del contrario,
    si la pieza tiene la capacidad de moverse a esa casilla, se la comerá y ocupará
    su posición.

16º Si una pieza es comida, se elimina de la partida.

17º La situación de Jaque, es la situación en la que el rey enemigo se ve amenazado o 
    atacado, y existen formas de evitarlo. En esta situación, el  usuario que tiene
    su rey en jaque, debe moverlo a una casilla segura, o bloquear la amenaza ya sea
    comiendose la pieza, o bloqueando la direccion de ataque con otra pieza.

18º La  situación de Jaque Mate, es la situación en la que el rey enemigo se ve 
    amenazado o atacado, y no existen forma de evitarlo.

19º El tablero es un 8x8 (columna * fila), siendo las columnas  a, b, c, d, e, f, g, 
    h y las filas 1 , 2, 3, 4, 5, 6, 7, 8. En el tablero se pueden dar combinaciones
    como : a1, f6 o h8. Siempre haciendo incapié en la columna primero y luego la fila.


QUE NO PUEDE HACER EL PROGRAMA:

    La captura al paso
    El doble paso del peón
    El enroque de las dos formas 
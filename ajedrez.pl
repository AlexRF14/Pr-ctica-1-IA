:- dynamic(casilla/3).

% Peones blancos
casilla(peonBlanco , 1 , 2).
casilla(peonBlanco , 2 , 2).
casilla(peonBlanco , 3 , 2).
casilla(peonBlanco , 4 , 2).
casilla(peonBlanco , 5 , 2).
casilla(peonBlanco , 6 , 2).
casilla(peonBlanco , 7 , 2).
casilla(peonBlanco , 8 , 2).

casilla(torreBlanco, 1 , 1).
casilla(torreBlanco, 8 , 1).
casilla(torreNegro, 1 , 8).
casilla(torreNegro, 8 , 8).

% Caballos
casilla(caballoBlanco, 2 , 1).
casilla(caballoBlanco, 7 , 1).
casilla(caballoNegro, 2 , 8).
casilla(caballoNegro, 7 , 8).

% Alfil
casilla(alfilBlanco, 3 , 1).
casilla(alfilBlanco, 6 , 1).
casilla(alfilNegro, 3 , 8).
casilla(alfilNegro, 6 , 8).

% Reina
casilla(reinaBlanco, 4 , 1).
casilla(reinaNegro, 4 , 8).

% Rey
casilla(reyBlanco, 5 , 1).
casilla(reyNegro, 5 , 8).

% Peones negras
casilla(peonNegro , 1 , 7).
casilla(peonNegro , 2 , 7).
casilla(peonNegro , 3 , 7).
casilla(peonNegro , 4 , 7).
casilla(peonNegro , 5 , 7).
casilla(peonNegro , 6 , 7).
casilla(peonNegro , 7 , 7).
casilla(peonNegro , 8 , 7).

movi(peonBlanco , Col , Fil , Prox_col , Prox_fil):-
        Prox_fil is Fil + 1,
        Prox_fil >= 1, Prox_fil =< 8,
        Prox_col >= 1, Prox_col =< 8,
        casilla(peonBlanco , Col , Fil),
        \+ evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil),
        \+ (casilla(_, Col, Prox_fil)),
        assert(casilla(peonBlanco , Col , Prox_fil)),
        retract(casilla(peonBlanco , Col , Fil)).

movi(peonBlanco , Col , Fil, Prox_col , Prox_fil):-
        Prox_fil is Fil + 1,
        (Prox_col is Col + 1; Prox_col is Col - 1),
        Prox_fil >= 1, Prox_fil =< 8,
        Prox_col >= 1, Prox_col =< 8,
        casilla(peonBlanco , Col , Fil),
        casilla(_, Prox_col , Prox_fil),
        \+ evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil),
        \+ casilla((peonBlanco, torreBlanco , alfilBlanco , reyBlanco ,  caballoBlanco , reinaBlanco) ,  Prox_col , Prox_fil),
        evitadorDeComerVacios(peonBlanco , Prox_col, Prox_fil),
        retract(casilla(peonBlanco , Col , Fil)).

movi(peonNegro , Col , Fil, Prox_col , Prox_fil):-
        Prox_fil is Fil - 1,
        Prox_fil >= 1, Prox_fil =< 8,
        Prox_col = Col,
        casilla(peonNegro , Col , Fil),
        \+ evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil),
        \+ (casilla(_, Col, Prox_fil)),
        assert(casilla(peonNegro , Col , Prox_fil)),
        retract(casilla(peonNegro , Col , Fil)).

movi(peonNegro , Col , Fil, Prox_col , Prox_fil):-
        Prox_fil is Fil - 1,
        (Prox_col is Col + 1; Prox_col is Col - 1),
        Prox_fil >= 1, Prox_fil =< 8,
        casilla(peonNegro , Col , Fil),
        casilla(_, Prox_col , Prox_fil),
        \+ evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil),
        \+ casilla((peonNegro, torreNegro , alfilNegro , reyNegro ,  caballoNegro , reinaNegro) ,  Prox_col , Prox_fil),
        evitadorDeComerVacios(peonNegro , Prox_col, Prox_fil),
        retract(casilla(peonNegro , Col , Fil)).

movi(caballoBlanco ,  Col , Fil , Prox_col , Prox_fil):-
        (Prox_fil is Fil + 2, Prox_col is Col + 1;
        Prox_fil is Fil + 2, Prox_col is Col - 1;
        Prox_fil is Fil - 2, Prox_col is Col + 1;
        Prox_fil is Fil - 2, Prox_col is Col - 1;
        Prox_fil is Fil + 1, Prox_col is Col + 2;
        Prox_fil is Fil + 1, Prox_col is Col - 2;
        Prox_fil is Fil - 1, Prox_col is Col + 2;
        Prox_fil is Fil - 1, Prox_col is Col - 2),
        Prox_fil >= 1, Prox_fil =< 8,
        Prox_col >= 1, Prox_col =< 8,
        casilla(caballoBlanco , Col , Fil),
        \+ casilla((peonBlanco, torreBlanco , alfilBlanco , reyBlanco ,  caballoBlanco , reinaBlanco) ,  Prox_col , Prox_fil),
        evitadorDeComerVacios(caballoBlanco , Prox_col, Prox_fil),
        retract(casilla(caballoBlanco , Col , Fil)).

movi(caballoNegro ,  Col , Fil , Prox_col , Prox_fil):-
        (Prox_fil is Fil + 2, Prox_col is Col + 1;
        Prox_fil is Fil + 2, Prox_col is Col - 1;
        Prox_fil is Fil - 2, Prox_col is Col + 1;
        Prox_fil is Fil - 2, Prox_col is Col - 1;
        Prox_fil is Fil + 1, Prox_col is Col + 2;
        Prox_fil is Fil + 1, Prox_col is Col - 2;
        Prox_fil is Fil - 1, Prox_col is Col + 2;
        Prox_fil is Fil - 1, Prox_col is Col - 2),
        Prox_fil >= 1, Prox_fil =< 8,
        Prox_col >= 1, Prox_col =< 8,
        casilla(caballoNegro , Col , Fil),
        \+ casilla((peonNegro, torreNegro , alfilNegro , reyNegro ,  caballoNegro , reinaNegro) ,  Prox_col , Prox_fil),
        evitadorDeComerVacios(caballoNegro , Prox_col, Prox_fil),
        retract(casilla(caballoNegro , Col , Fil)).

movi(alfilBlanco , Col , Fil , Prox_fil, Prox_col):-
        (Prox_fil is Fil - 1, Prox_col is Col - 1;
        Prox_fil is Fil -2 , Prox_col is Col - 2;
        Prox_fil is Fil - 3, Prox_col is Col - 3;
        Prox_fil is Fil - 4, Prox_col is Col - 4;
        Prox_fil is Fil - 5, Prox_col is Col - 5;
        Prox_fil is Fil -6 , Prox_col is Col - 6;
        Prox_fil is Fil - 7, Prox_col is Col - 7;
        Prox_fil is Fil + 1, Prox_col is Col - 1;
        Prox_fil is Fil + 2, Prox_col is Col - 2;
        Prox_fil is Fil + 3, Prox_col is Col - 3;
        Prox_fil is Fil + 4, Prox_col is Col - 4;
        Prox_fil is Fil + 5, Prox_col is Col - 5;
        Prox_fil is Fil + 6, Prox_col is Col - 6;
        Prox_fil is Fil + 7, Prox_col is Col - 7;
        Prox_fil is Fil - 1, Prox_col is Col + 1;
        Prox_fil is Fil - 2, Prox_col is Col + 2;
        Prox_fil is Fil - 3, Prox_col is Col + 3;
        Prox_fil is Fil - 4, Prox_col is Col + 4;
        Prox_fil is Fil - 5, Prox_col is Col + 5;
        Prox_fil is Fil - 6, Prox_col is Col + 6;
        Prox_fil is Fil - 7, Prox_col is Col + 7;
        Prox_fil is Fil + 1, Prox_col is Col + 1;
        Prox_fil is Fil + 2, Prox_col is Col + 2;
        Prox_fil is Fil + 3, Prox_col is Col + 3;
        Prox_fil is Fil + 4, Prox_col is Col + 4;
        Prox_fil is Fil + 5, Prox_col is Col + 5;
        Prox_fil is Fil + 6, Prox_col is Col + 6;
        Prox_fil is Fil + 7, Prox_col is Col + 7),
        Prox_fil >= 1, Prox_fil =< 8,
        Prox_col >= 1, Prox_col =< 8,
        casilla(alfilBlanco , Col , Fil),
        \+ evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil),
        \+ casilla((peonBlanco, torreBlanco , alfilBlanco , reyBlanco ,  caballoBlanco , reinaBlanco) ,  Prox_col , Prox_fil),
        evitadorDeComerVacios(alfilBlanco , Prox_col, Prox_fil),
        retract(casilla(alfilBlanco , Col , Fil)).

movi(alfilNegro , Col , Fil , Prox_fil, Prox_col):-
        (Prox_fil is Fil - 1, Prox_col is Col - 1;
        Prox_fil is Fil -2 , Prox_col is Col - 2;
        Prox_fil is Fil - 3, Prox_col is Col - 3;
        Prox_fil is Fil - 4, Prox_col is Col - 4;
        Prox_fil is Fil - 5, Prox_col is Col - 5;
        Prox_fil is Fil -6 , Prox_col is Col - 6;
        Prox_fil is Fil - 7, Prox_col is Col - 7;
        Prox_fil is Fil + 1, Prox_col is Col - 1;
        Prox_fil is Fil + 2, Prox_col is Col - 2;
        Prox_fil is Fil + 3, Prox_col is Col - 3;
        Prox_fil is Fil + 4, Prox_col is Col - 4;
        Prox_fil is Fil + 5, Prox_col is Col - 5;
        Prox_fil is Fil + 6, Prox_col is Col - 6;
        Prox_fil is Fil + 7, Prox_col is Col - 7;
        Prox_fil is Fil - 1, Prox_col is Col + 1;
        Prox_fil is Fil - 2, Prox_col is Col + 2;
        Prox_fil is Fil - 3, Prox_col is Col + 3;
        Prox_fil is Fil - 4, Prox_col is Col + 4;
        Prox_fil is Fil - 5, Prox_col is Col + 5;
        Prox_fil is Fil - 6, Prox_col is Col + 6;
        Prox_fil is Fil - 7, Prox_col is Col + 7;
        Prox_fil is Fil + 1, Prox_col is Col + 1;
        Prox_fil is Fil + 2, Prox_col is Col + 2;
        Prox_fil is Fil + 3, Prox_col is Col + 3;
        Prox_fil is Fil + 4, Prox_col is Col + 4;
        Prox_fil is Fil + 5, Prox_col is Col + 5;
        Prox_fil is Fil + 6, Prox_col is Col + 6;
        Prox_fil is Fil + 7, Prox_col is Col + 7),
        Prox_fil >= 1, Prox_fil =< 8,
        Prox_col >= 1, Prox_col =< 8,
        casilla(alfilNegro , Col , Fil),
        \+ evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil),
        \+ casilla((peonNegro, torreNegro , alfilNegro , reyNegro ,  caballoNegro , reinaNegro) ,  Prox_col , Prox_fil),
        evitadorDeComerVacios(alfilNegro , Prox_col, Prox_fil),
        retract(casilla(alfilNegro , Col , Fil)).

movi(torreBlanco,  Col, Fil, Prox_col, Prox_fil):-
        (Prox_col is Col + 1; Prox_col is Col - 1;
         Prox_col is Col + 2; Prox_col is Col - 2;
         Prox_col is Col + 3; Prox_col is Col - 3;
         Prox_col is Col + 4; Prox_col is Col - 4;
         Prox_col is Col + 5; Prox_col is Col - 5;
         Prox_col is Col + 6; Prox_col is Col - 6;
         Prox_col is Col + 7; Prox_col is Col - 7;
         Prox_fil is Fil + 1; Prox_fil is Fil - 1;
         Prox_fil is Fil + 2; Prox_fil is Fil - 2;
         Prox_fil is Fil + 3; Prox_fil is Fil - 3;
         Prox_fil is Fil + 4; Prox_fil is Fil - 4;
         Prox_fil is Fil + 5; Prox_fil is Fil - 5;
         Prox_fil is Fil + 6; Prox_fil is Fil - 6;
         Prox_fil is Fil + 7; Prox_fil is Fil - 7),
        Prox_fil >= 1, Prox_fil =< 8,
        Prox_col >= 1, Prox_col =< 8,
        casilla(torreBlanco , Col , Fil),
        \+ evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil),
        \+ casilla((peonBlanco, torreBlanco , alfilBlanco , reyBlanco ,  caballoBlanco , reinaBlanco) ,  Prox_col , Prox_fil),
        evitadorDeComerVacios(torreBlanco , Prox_col, Prox_fil),
        retract(casilla(torreBlanco , Col , Fil)).

movi(torreNegro,  Col, Fil, Prox_col, Prox_fil):-
        (Prox_col is Col + 1; Prox_col is Col - 1;
         Prox_col is Col + 2; Prox_col is Col - 2;
         Prox_col is Col + 3; Prox_col is Col - 3;
         Prox_col is Col + 4; Prox_col is Col - 4;
         Prox_col is Col + 5; Prox_col is Col - 5;
         Prox_col is Col + 6; Prox_col is Col - 6;
         Prox_col is Col + 7; Prox_col is Col - 7;
         Prox_fil is Fil + 1; Prox_fil is Fil - 1;
         Prox_fil is Fil + 2; Prox_fil is Fil - 2;
         Prox_fil is Fil + 3; Prox_fil is Fil - 3;
         Prox_fil is Fil + 4; Prox_fil is Fil - 4;
         Prox_fil is Fil + 5; Prox_fil is Fil - 5;
         Prox_fil is Fil + 6; Prox_fil is Fil - 6;
         Prox_fil is Fil + 7; Prox_fil is Fil - 7),
        Prox_fil >= 1, Prox_fil =< 8,
        Prox_col >= 1, Prox_col =< 8,
        casilla(torreNegro , Col , Fil),
        \+ evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil),
        \+ casilla((peonNegro, torreNegro , alfilNegro , reyNegro ,  caballoNegro , reinaNegro) ,  Prox_col , Prox_fil),
        evitadorDeComerVacios(torreNegro , Prox_col, Prox_fil),
        retract(casilla(torreNegro , Col , Fil)).

movi(reinaBlanco , Col , Fil, Prox_col, Prox_fil):-
        (Prox_col is Col + 1; Prox_col is Col - 1;
         Prox_col is Col + 2; Prox_col is Col - 2;
         Prox_col is Col + 3; Prox_col is Col - 3;
         Prox_col is Col + 4; Prox_col is Col - 4;
         Prox_col is Col + 5; Prox_col is Col - 5;
         Prox_col is Col + 6; Prox_col is Col - 6;
         Prox_col is Col + 7; Prox_col is Col - 7;
         Prox_fil is Fil + 1; Prox_fil is Fil - 1;
         Prox_fil is Fil + 2; Prox_fil is Fil - 2;
         Prox_fil is Fil + 3; Prox_fil is Fil - 3;
         Prox_fil is Fil + 4; Prox_fil is Fil - 4;
         Prox_fil is Fil + 5; Prox_fil is Fil - 5;
         Prox_fil is Fil + 6; Prox_fil is Fil - 6;
         Prox_fil is Fil + 7; Prox_fil is Fil - 7;

        Prox_fil is Fil - 1, Prox_col is Col - 1;
        Prox_fil is Fil -2 , Prox_col is Col - 2;
        Prox_fil is Fil - 3, Prox_col is Col - 3;
        Prox_fil is Fil - 4, Prox_col is Col - 4;
        Prox_fil is Fil - 5, Prox_col is Col - 5;
        Prox_fil is Fil - 6, Prox_col is Col - 6;
        Prox_fil is Fil - 7, Prox_col is Col - 7;
        Prox_fil is Fil + 1, Prox_col is Col - 1;
        Prox_fil is Fil + 2, Prox_col is Col - 2;
        Prox_fil is Fil + 3, Prox_col is Col - 3;
        Prox_fil is Fil + 4, Prox_col is Col - 4;
        Prox_fil is Fil + 5, Prox_col is Col - 5;
        Prox_fil is Fil + 6, Prox_col is Col - 6;
        Prox_fil is Fil + 7, Prox_col is Col - 7;
        Prox_fil is Fil - 1, Prox_col is Col + 1;
        Prox_fil is Fil - 2, Prox_col is Col + 2;
        Prox_fil is Fil - 3, Prox_col is Col + 3;
        Prox_fil is Fil - 4, Prox_col is Col + 4;
        Prox_fil is Fil - 5, Prox_col is Col + 5;
        Prox_fil is Fil - 6, Prox_col is Col + 6;
        Prox_fil is Fil - 7, Prox_col is Col + 7;
        Prox_fil is Fil + 1, Prox_col is Col + 1;
        Prox_fil is Fil + 2, Prox_col is Col + 2;
        Prox_fil is Fil + 3, Prox_col is Col + 3;
        Prox_fil is Fil + 4, Prox_col is Col + 4;
        Prox_fil is Fil + 5, Prox_col is Col + 5;
        Prox_fil is Fil + 6, Prox_col is Col + 6;
        Prox_fil is Fil + 7, Prox_col is Col + 7),
        Prox_fil >= 1, Prox_fil =< 8,
        Prox_col >= 1, Prox_col =< 8,
        \+ evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil),
        casilla(reinaBlanco , Col , Fil),
        \+ casilla((peonBlanco, torreBlanco , alfilBlanco , reyBlanco ,  caballoBlanco , reinaBlanco) ,  Prox_col , Prox_fil),
        evitadorDeComerVacios(reinaBlanco , Prox_col, Prox_fil),
        retract(casilla(reinaBlanco , Col , Fil)).

movi(reinaNegro , Col , Fil, Prox_col, Prox_fil):-
        (Prox_col is Col + 1; Prox_col is Col - 1;
         Prox_col is Col + 2; Prox_col is Col - 2;
         Prox_col is Col + 3; Prox_col is Col - 3;
         Prox_col is Col + 4; Prox_col is Col - 4;
         Prox_col is Col + 5; Prox_col is Col - 5;
         Prox_col is Col + 6; Prox_col is Col - 6;
         Prox_col is Col + 7; Prox_col is Col - 7;
         Prox_fil is Fil + 1; Prox_fil is Fil - 1;
         Prox_fil is Fil + 2; Prox_fil is Fil - 2;
         Prox_fil is Fil + 3; Prox_fil is Fil - 3;
         Prox_fil is Fil + 4; Prox_fil is Fil - 4;
         Prox_fil is Fil + 5; Prox_fil is Fil - 5;
         Prox_fil is Fil + 6; Prox_fil is Fil - 6;
         Prox_fil is Fil + 7; Prox_fil is Fil - 7;

        Prox_fil is Fil - 1, Prox_col is Col - 1;
        Prox_fil is Fil -2 , Prox_col is Col - 2;
        Prox_fil is Fil - 3, Prox_col is Col - 3;
        Prox_fil is Fil - 4, Prox_col is Col - 4;
        Prox_fil is Fil - 5, Prox_col is Col - 5;
        Prox_fil is Fil -6 , Prox_col is Col - 6;
        Prox_fil is Fil - 7, Prox_col is Col - 7;
        Prox_fil is Fil + 1, Prox_col is Col - 1;
        Prox_fil is Fil + 2, Prox_col is Col - 2;
        Prox_fil is Fil + 3, Prox_col is Col - 3;
        Prox_fil is Fil + 4, Prox_col is Col - 4;
        Prox_fil is Fil + 5, Prox_col is Col - 5;
        Prox_fil is Fil + 6, Prox_col is Col - 6;
        Prox_fil is Fil + 7, Prox_col is Col - 7;
        Prox_fil is Fil - 1, Prox_col is Col + 1;
        Prox_fil is Fil - 2, Prox_col is Col + 2;
        Prox_fil is Fil - 3, Prox_col is Col + 3;
        Prox_fil is Fil - 4, Prox_col is Col + 4;
        Prox_fil is Fil - 5, Prox_col is Col + 5;
        Prox_fil is Fil - 6, Prox_col is Col + 6;
        Prox_fil is Fil - 7, Prox_col is Col + 7;
        Prox_fil is Fil + 1, Prox_col is Col + 1;
        Prox_fil is Fil + 2, Prox_col is Col + 2;
        Prox_fil is Fil + 3, Prox_col is Col + 3;
        Prox_fil is Fil + 4, Prox_col is Col + 4;
        Prox_fil is Fil + 5, Prox_col is Col + 5;
        Prox_fil is Fil + 6, Prox_col is Col + 6;
        Prox_fil is Fil + 7, Prox_col is Col + 7),
        Prox_fil >= 1, Prox_fil =< 8,
        Prox_col >= 1, Prox_col =< 8,
        \+ evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil),
        casilla(reinaNegro , Col , Fil),
        \+ casilla((peonNegro, torreNegro , alfilNegro , reyNegro ,  caballoNegro , reinaNegro) ,  Prox_col , Prox_fil),
        evitadorDeComerVacios(reinaNegro , Prox_col, Prox_fil),
        retract(casilla(reinaNegro , Col , Fil)).

movi(reyBlanco  , Col , Fil , Prox_col , Prox_fil) :-
        (Prox_col is Col + 1; Prox_col is Col - 1;
         Prox_fil is Fil + 1; Prox_fil is Fil - 1;
         Prox_col is Col + 1, Prox_fil is Fil - 1;
         Prox_col is Col - 1, Prox_fil is Fil - 1;
         Prox_col is Col + 1, Prox_fil is Fil + 1;
         Prox_col is Col - 1, Prox_fil is Fil + 1),
         Prox_fil >= 1, Prox_fil =< 8,
         Prox_col >= 1, Prox_col =< 8,
         casilla(reyBlanco , Col , Fil),
        \+ evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil),
         \+ casilla((peonBlanco, torreBlanco , alfilBlanco , reyBlanco ,  caballoBlanco , reinaBlanco) ,  Prox_col , Prox_fil),
        evitadorDeComerVacios(reyBlanco , Prox_col, Prox_fil),
        retract(casilla(reyBlanco , Col , Fil)).

movi(reyNegro  , Col , Fil , Prox_col , Prox_fil) :-
        (Prox_col is Col + 1, Prox_fil is Fil;
        Prox_col is Col - 1, Prox_fil is Fil;
        Prox_col is Col, Prox_fil is Fil + 1;
        Prox_col is Col, Prox_fil is Fil - 1;
        Prox_col is Col + 1, Prox_fil is Fil + 1;
        Prox_col is Col - 1, Prox_fil is Fil - 1;
        Prox_col is Col + 1, Prox_fil is Fil - 1;
        Prox_col is Col - 1, Prox_fil is Fil + 1),
         Prox_fil >= 1, Prox_fil =< 8,
         Prox_col >= 1, Prox_col =< 8,
         casilla(reyNegro , Col , Fil),
         \+ evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil),
         \+ casilla((peonNegro, torreNegro , alfilNegro , reyNegro ,  caballoNegro , reinaNegro) ,  Prox_col , Prox_fil),
         evitadorDeComerVacios(reyNegro , Prox_col, Prox_fil),
        % retract(casilla(_ ,  Prox_col , Prox_fil)),
        % assert(casilla(reyNegro , Prox_col , Prox_fil)),
        retract(casilla(reyNegro , Col , Fil)).

evitadorDeSaltos(Col , Fil , Prox_col , Prox_fil):-
        (Col = Prox_col, Fil < Prox_fil, 
        between(Fil, Prox_fil - 1, F), F \= Fil, casilla(_, Col, F);
                Col = Prox_col, Fil > Prox_fil, 
        between(Prox_fil, Fil + 1, F), F \= Fil, casilla(_, Col, F);
                Fil = Prox_fil - 1, Col < Prox_col, 
        between(Col, Prox_col, C), C \= Col, casilla(_, C, Fil);
                Fil = Prox_fil + 1, Col > Prox_col, 
        between(Prox_col, Col, C), C \= Col, casilla(_, C, Fil)).

evitadorDeComerVacios(Pieza, Prox_col, Prox_fil):- 
    (casilla(_, Prox_col, Prox_fil) -> 
    retract(casilla(_, Prox_col, Prox_fil)), 
    assert(casilla(Pieza, Prox_col, Prox_fil)) 
    ; 
    assert(casilla(Pieza, Prox_col, Prox_fil))).

        
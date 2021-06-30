% BASE DE CONOCIMIENTOS
vivenEnLaMansionDreadbury(tiaAgatha).
vivenEnLaMansionDreadbury(charles).
vivenEnLaMansionDreadbury(mayordomo).

agathaOdia(Alguien) :-
    vivenEnLaMansionDreadbury(Alguien),
    Alguien \= mayordomo,
    Alguien \= tiaAgatha.
mayordomoOdia(Alguien) :-
    vivenEnLaMansionDreadbury(Alguien),
    Alguien \= mayordomo,
    Alguien \= tiaAgatha.

charlesOdia(Alguien):-
    vivenEnLaMansionDreadbury(Alguien),
    not(agathaOdia(Alguien)).
    
esMasRicoQueTiaAgatha(Alguien):-
    not(mayordomoOdia(Alguien)),
    vivenEnLaMansionDreadbury(Alguien).
quienOdiaAAgatha(Odiador):-
    odiadorOdiado(Odiador,tiaAgatha).

odiadorOdiado(tiaAgatha,charles).
odiadorOdiado(mayordomo,charles).
odiadorOdiado(charles,mayordomo).
odiadorOdiado(charles,tiaAgatha).

alguienOdiaA(Odiado):-
    odiadorOdiado(_,Odiado).


%Quien mata es porque odia a su víctima y no es más rico que ella. Además, quien mata debe vivir en la mansión Dreadbury.
mata(Asesino,Victima):-
    odiadorOdiado(Asesino,Victima),
    vivenEnLaMansionDreadbury(Asesino),
    not(esMasRicoQueTiaAgatha(Asesino)).


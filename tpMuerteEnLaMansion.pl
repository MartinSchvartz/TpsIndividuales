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

/* 1. El programa puede mostrar quien mato a Tia Agatha con la ultima consulta, mata(Asesino,Victima). Si hacemos la consulta como mata(Asesino,tiaAgatha),
nos devuelve Asesino = charles.
2. 
-Alguien odia a milhouse? eso podemos resolverlo consultando odiadorOdiado(_,milhouse), lo cual ons devuelve un false.
-A quien odia Charles?  haciendo la consulta charlesOdia(Quien), obtenermos como resultado que charles odia a tia agatha y al mayordomo
Quien = tiaAgatha ;
Quien = mayordomo.
-El nombre de quien odia a tia agatha? esto se resuelve con la consulta odiadorOdiado(OdiaAAgatha, tiaAgatha). reotrnandonos OdiaAAgatha = charles, siendo asi que
charles odia a tia Agatha.
-Todos los odiadores y sus odiados se puede responder con la consulta odiadorOdiado(Odiador,Odiado). Lo cual nos dice quien odia a quien.
-Para saber si el mayordomo odia a alguien simplemente consultamos mayordomoOdia(_). lo cual nos dice true ya que odia a charles
*/

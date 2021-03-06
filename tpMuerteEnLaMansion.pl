% BASE DE CONOCIMIENTOS
vivenEnLaMansionDreadbury(tiaAgatha).
vivenEnLaMansionDreadbury(charles).
vivenEnLaMansionDreadbury(mayordomo).

esMasRicoQue(tiaAgatha,AlguienMenosRico):-
    not(odia(mayordomo,AlguienMenosRico)),
    vivenEnLaMansionDreadbury(AlguienMenosRico).

odia(tiaAgatha, Odiado):-
    vivenEnLaMansionDreadbury(Odiado),
    Odiado \= mayordomo,
    Odiado \= tiaAgatha.    
odia(mayordomo, Odiado):-
       odia(tiaAgatha,Odiado).    
odia(charles, Odiado):-
    vivenEnLaMansionDreadbury(Odiado),
    not(odia(tiaAgatha,Odiado)).
%Quien mata es porque odia a su víctima y no es más rico que ella. Además, quien mata debe vivir en la mansión Dreadbury.
mata(Asesino,Victima):-
    odia(Asesino,Victima),
    vivenEnLaMansionDreadbury(Asesino),
    not(esMasRicoQue(Victima,Asesino)).


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

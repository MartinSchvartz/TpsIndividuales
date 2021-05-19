import Text.Show.Functions
data Jugador = Jugador {
    nombre :: String,
    dinero :: Int,
    tactica :: String,
    propiedadesCompradas :: [Propiedad],
    acciones :: [Accion]

} deriving (Show)
type Accion = Jugador -> Jugador

data Propiedad = UnaPropiedad {
    titulo :: String,
    precio :: Int
    } deriving(Eq,Show)

carolina :: Jugador
carolina = Jugador{nombre="Carolina", dinero=500, tactica="Accionista",propiedadesCompradas=[libertador], acciones=[pasarPorElBanco, pagarAAccionistas,gritar]}
manuel :: Jugador
manuel = Jugador{nombre="Manuel", dinero=200, tactica="Oferente singular",propiedadesCompradas=[], acciones=[pasarPorElBanco, enojarse]}

libertador:: Propiedad
libertador =  UnaPropiedad {titulo = "Av Libertador 4515", precio = 100}
palermo:: Propiedad
palermo =  UnaPropiedad {titulo = "Av Scalabrini Ortiz 4201", precio = 50}

mapDinero :: (Int -> Int) -> Jugador ->Jugador
mapDinero unaFuncion unJugador = unJugador {dinero = unaFuncion . dinero $ unJugador }
mapPropiedadesCompradas :: ([Propiedad] -> [Propiedad]) -> Jugador ->Jugador
mapPropiedadesCompradas unaFuncion unJugador = unJugador {propiedadesCompradas = unaFuncion . propiedadesCompradas $ unJugador }



pasarPorElBanco :: Accion
pasarPorElBanco unJugador = mapDinero (+40) unJugador  {tactica = "Comprador compulsivo"}

enojarse :: Accion
enojarse unJugador = mapDinero (+50) unJugador  { acciones = acciones unJugador ++ [gritar]}

gritar :: Accion
gritar unJugador = unJugador {nombre = "AHHHH" ++ nombre unJugador}


esPropiedadGanadora :: Jugador->  Bool
esPropiedadGanadora unJugador = tactica unJugador == "Accionista" || tactica unJugador ==  "Oferente singular"

subastar :: Propiedad ->  Jugador -> Jugador
subastar unaPropiedad unJugador
    | esPropiedadGanadora unJugador && dinero unJugador >= precio unaPropiedad = mapPropiedadesCompradas (++ [unaPropiedad]) (mapDinero (subtract (precio unaPropiedad)) unJugador)
    | otherwise = unJugador

precioAlquilerPropiedad :: Propiedad -> Int
precioAlquilerPropiedad unaPropiedad
 | precio unaPropiedad < 150 = 10
 | otherwise = 20


listaDeAlquileres :: Jugador -> [Int]
listaDeAlquileres unJugador = map precioAlquilerPropiedad (propiedadesCompradas unJugador)

cobrarAlquileres :: Accion
cobrarAlquileres unJugador  = mapDinero (+ sum (listaDeAlquileres unJugador)) unJugador

pagarAAccionistas :: Accion
pagarAAccionistas unJugador
    | tactica unJugador == "Accionista" = mapDinero (+200) unJugador
    | otherwise = unJugador{dinero =  dinero unJugador - 100}


sumarleBerrinche :: Jugador -> Jugador
sumarleBerrinche = mapDinero (+10)

gritarYSumar :: Jugador -> Jugador
gritarYSumar = gritar . sumarleBerrinche

hacerBerrinchePor :: Propiedad -> Accion
hacerBerrinchePor unaPropiedad unJugador
    | dinero unJugador >= precio unaPropiedad = subastar unaPropiedad unJugador
    | otherwise = hacerBerrinchePor unaPropiedad (gritarYSumar unJugador)





ultimaRonda :: Jugador -> Jugador
ultimaRonda unJugador = foldl1 (.) (acciones unJugador) unJugador

ganador ::  String
ganador
    | dinero (ultimaRonda manuel ) > dinero (ultimaRonda carolina) = "GANO MANUEL VIEJAA"
    | dinero (ultimaRonda manuel) < dinero (ultimaRonda carolina) ="GANO CAROLINA VAMOS CARAJO"
    | dinero (ultimaRonda manuel) == dinero (ultimaRonda carolina) = "EMPATARON VIEJO QUE ABURRIDO"

-- NO vi que habia q hacer juego final por eso hice ganador asi q la dejo y hago abajo juego final xd


dineroEnUltimaRonda :: Jugador -> Int
dineroEnUltimaRonda = dinero . ultimaRonda

juegoFinal :: Jugador -> Jugador -> Jugador
juegoFinal jugador1 jugador2
    | dineroEnUltimaRonda jugador1 >= dineroEnUltimaRonda jugador2 = jugador1
    | otherwise = jugador2


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
carolina = Jugador{nombre="Carolina", dinero=100, tactica="Accionista",propiedadesCompradas=[libertador], acciones=[pasarPorElBanco, pagarAAccionistas,gritar]}
manuel :: Jugador
manuel = Jugador{nombre="Manuel", dinero=300, tactica="Oferente singular",propiedadesCompradas=[], acciones=[pasarPorElBanco, enojarse]}

libertador:: Propiedad
libertador =  UnaPropiedad {titulo = "Av Libertador 4515", precio = 100}
palermo:: Propiedad
palermo =  UnaPropiedad {titulo = "Av Scalabrini Ortiz 4201", precio = 300}


pasarPorElBanco :: Accion
pasarPorElBanco unJugador =  unJugador  {dinero = dinero unJugador + 40, tactica = "Comprador compulsivo"}

enojarse :: Accion
enojarse unJugador = unJugador  {dinero = dinero unJugador + 50, acciones = acciones unJugador ++ [gritar]}

gritar :: Accion
gritar unJugador = unJugador {nombre = "AHHHH" ++ nombre unJugador}


compararTactica :: Jugador->  Bool
compararTactica unJugador = tactica unJugador == "Accionista" || tactica unJugador ==  "Oferente singular"

subastar :: Propiedad ->  Jugador -> Jugador
subastar unaPropiedad unJugador
    | compararTactica unJugador && dinero unJugador >= precio unaPropiedad = unJugador {propiedadesCompradas=propiedadesCompradas unJugador ++ [unaPropiedad], dinero =  dinero unJugador -  precio unaPropiedad}
    | otherwise = unJugador

propiedadBarata :: Propiedad -> Int
propiedadBarata unaPropiedad
 | precio unaPropiedad < 150 = 10
 | otherwise = 20


listaDeAlquileres :: Jugador -> [Int]
listaDeAlquileres unJugador = map propiedadBarata (propiedadesCompradas unJugador)

cobrarAlquileres :: Accion
cobrarAlquileres unJugador  = unJugador {dinero = dinero unJugador + sum (listaDeAlquileres unJugador)}

pagarAAccionistas :: Accion
pagarAAccionistas unJugador
    | tactica unJugador == "Accionista" =  unJugador{dinero =  dinero unJugador + 200}
    | otherwise = unJugador{dinero =  dinero unJugador - 100}


sumarleBerrinche :: Jugador -> Jugador
sumarleBerrinche unJugador = unJugador {dinero = dinero unJugador + 10}
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
juegoFinal :: Jugador -> Jugador -> Jugador
juegoFinal jugador1 jugador2
    | dinero (ultimaRonda jugador1) >= dinero (ultimaRonda jugador2) = jugador1
    | dinero (ultimaRonda jugador1) < dinero (ultimaRonda jugador2) = jugador2
    

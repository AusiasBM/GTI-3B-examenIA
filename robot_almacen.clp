
(deffacts hechos 
    ( stockPalets naranjas 5 manzanas 3 caquis 7 uva 2 )
    ( pedido naranjas 4 manzanas 0 caquis 0 uva 0 ) 
    ( robot cajas 0 maxPuede 3)
    ( lineaPedido naranjas 0 manzanas 0 caquis 0 uva 0 )
)

(defrule noHayBastantesCajas
    ( declare (salience 20))
    ( pedido naranjas ?n manzanas ?m caquis ?c uva ?u )
    ( stockPalets naranjas ?ns manzanas ?ms caquis ?cs uva ?us )
    ( test ( or (> ?n ?ns ) (> ?m ?ms ) (> ?c ?cs ) (> ?u ?us )) )
    =>
    ( halt )
    ( printout t"No hay bastantes cajas para el pedido" crlf)
)

(defrule cogerCajasNaranja
    ( declare (salience 2))
    ( robot cajas ?nc maxPuede ?p )
    ( pedido naranjas ?n $?palets )
    ( lineaPedido naranajas ?nl $? )
    ( test ( and (< ?nc ?p ) (< ?nl ?n )))
    =>
    ( assert ( pedido naranjas (- ?n 1) $?palets ) )
    ( assert ( robot cajas (+ ?n 1) maxPuede ?p ) )
    ( printout t"Cojo una caja de naranjas" crlf)
)

(defrule depositarCajas
    ( robot cajas ?n maxPuede ?p )
    ( pedido naranjas ?nl manzanas ?ml caquis ?cl uva ?ul )
    ( pedido naranjas ?n manzanas ?m caquis ?c uva ?u )
    ( test (or (== ?n ?p ) (= ?nl ?n ) (= ?ml ?m ) (= ?cl ?c ) (= ?ul ?u ) ))
    =>
    ( assert ( robot cajas 0 maxPuede ?p ) )
    ( printout t"Deposito las cajas" crlf)
)

(defrule pedidoCompletado
    ( declare (salience 10))
    ( pedido naranjas ?n manzanas ?m caquis ?c uva ?u )
    ( test ( and (= ?n 0 ) (= ?m 0 ) (= ?c 0 ) (= ?u 0 )) )
    =>
    ( halt )
    ( printout t"Pedido comletado" crlf)
)

(deffacts hechos 
    ( stockPalets naranjas 5 manzanas 3 caquis 7 uva 2 )
    ( pedido naranjas 4 manzanas 0 caquis 0 uva 0 ) 
    ( robot cajas 0 maxPuede 3)
)

(defrule hayBastanteCajas
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
    ?f1 <- ( robot cajas ?n maxPuede ?p )
    ?f2 <- ( pedido naranjas ?n manzanas ?m caquis ?c uva ?u )
    ( test ( and (< ?n ?p ) (> ?n 0 )))
    =>
    ( assert ( pedido naranjas (- ?n 1) manzanas ?m caquis ?c uva ?u ) )
    ( assert ( robot cajas (+ ?n 1) maxPuede ?p ) )
    ( retract ?f1 ?f2 )
    ( printout t"Cojo una caja de naranjas" crlf)
)

(defrule depositarCajas
    ?f1 <- ( robot cajas ?n maxPuede ?p )
    ( pedido naranjas ?n manzanas ?m caquis ?c uva ?u )
    ( test (<= ?n ?p ))
    =>
    ( assert ( robot cajas 0 maxPuede ?p ) )
    ( retract ?f1 )
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
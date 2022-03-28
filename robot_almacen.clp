
(deffacts hechos 
    ( stockPalets naranjas 5 manzanas 3 caquis 7 uva 2 )
    ( pedido naranjas 4 manzanas 0 caquis 0 uva 0 ) 
    ( lineaPedido naranjas 0 manzanas 0 caquis 0 uva 0 )
    ( robot naranjas 0 manzanas 0 caquis 0 uva 0 total 0 maxPuede 3)
)

(defrule cogerCajasNaranja
    ( robot naranjas ?nr $?otros total ?ct maxPuede ?p )
    ( pedido naranjas ?n $?palets )
    ( lineaPedido naranajas ?nl $? )
    ( test ( and (< ?ct ?p ) (< ?nl ?n )))
    =>
    ( assert ( robot naranjas (+ ?nr 1) $?otros total (+ ?ct 1) maxPuede ?p ) )
    ( printout t"Cojo una caja de naranjas")
)

(defrule depositarCajas
    ( lineaPedido naranjas ?nl manzanas ?ml caquis ?cl uva ?ul )
    ( robot naranjas ?nr manzanas ?mr caquis ?cr uva ?ur total ?ct maxPuede ?p )
    ( test (= ?ct ?p ))
    =>
    ( assert ( lineaPedido naranjas (+ ?nl ?nr) manzanas (+ ?ml ?mr) caquis (+ ?cl ?cr ) uva (+ ?ul ?ur) ) )
    ( assert ( robot naranjas 0 manzanas 0 caquis 0 uva 0 total 0 maxPuede ?p ) )
    ( printout t"Deposito las cajas")
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

(defrule pedidoCompletado
    ( declare (salience 10))
    ( lineaPedido $?p)
    ( pedido $?p ) 
    =>
    ( halt )
    ( printout t"Pedido comletado" crlf)
)
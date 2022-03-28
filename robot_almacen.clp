
(deffacts hechos 
    ( stockPalets naranjas 5 manzanas 3 caquis 7 uva 2 )
    ( pedido naranjas 3 manzanas 0 caquis 0 uva 0 ) 
    ( lineaPedido naranjas 0 manzanas 0 caquis 0 uva 0 )
    ( robot naranjas 0 manzanas 0 caquis 0 uva 0 total 0 maxPuede 3)
)

(defrule cogerCajasNaranja
    ( declare (salience 8))
    ( robot naranjas ?nr $?otros total ?ct maxPuede ?p )
    ( pedido naranjas ?n $? )
    ( lineaPedido naranjas ?nl $? )
    ( test ( and (< ?ct ?p ) (< ?nl ?n )))
    =>
    ( assert ( robot naranjas (+ ?nr 1) $?otros total (+ ?ct 1) maxPuede ?p ) )
    ( printout t"Cojo una caja de naranjas" crlf)
)

(defrule cogerCajasManzanas
    ( declare (salience 8))
    ( robot $?otros1 manzanas ?mr $?otros total ?ct maxPuede ?p )
    ( pedido $? manzanas ?m $? )
    ( lineaPedido $? manzanas ?ml $? )
    ( test ( and (< ?ct ?p ) (< ?ml ?m )))
    =>
    ( assert ( robot $?otros1 manzanas (+ ?mr 1) $?otros total (+ ?ct 1) maxPuede ?p ) )
    ( printout t"Cojo una caja de naranjas" crlf)
)

(defrule cogerCajasCaquis
    ( declare (salience 8))
    ( robot $?otros1 caquis ?cr $?otros total ?ct maxPuede ?p )
    ( pedido $? caquis ?c $? )
    ( lineaPedido $? caquis ?cl $? )
    ( test ( and (< ?ct ?p ) (< ?cl ?c )))
    =>
    ( assert ( robot $?otros1 caquis (+ ?cr 1) $?otros total (+ ?ct 1) maxPuede ?p ) )
    ( printout t"Cojo una caja de naranjas" crlf)
)

(defrule cogerCajasUva
    ( declare (salience 8))
    ( robot $?otros1 uva ?ur $?otros total ?ct maxPuede ?p )
    ( pedido $? uva ?u $? )
    ( lineaPedido $? uva ?ul $? )
    ( test ( and (< ?ct ?p ) (< ?ul ?u )))
    =>
    ( assert ( robot $?otros1 uva (+ ?ur 1) $?otros total (+ ?ct 1) maxPuede ?p ) )
    ( printout t"Cojo una caja de naranjas" crlf)
)

(defrule depositarCajas
    ( declare (salience 1))
    ( lineaPedido naranjas ?nl manzanas ?ml caquis ?cl uva ?ul )
    ( robot naranjas ?nr manzanas ?mr caquis ?cr uva ?ur total ?ct maxPuede ?p )
    ( test (or (= ?ct ?p ) (> ?nr 0 ) (> ?mr 0 ) (> ?cr 0 ) (> ?ur 0 ) ))
    =>
    ( assert ( lineaPedido naranjas (+ ?nl ?nr) manzanas (+ ?ml ?mr) caquis (+ ?cl ?cr ) uva (+ ?ul ?ur) ) )
    ( assert ( robot naranjas 0 manzanas 0 caquis 0 uva 0 total 0 maxPuede ?p ) )
    ( printout t"Deposito las cajas" crlf)
)

(defrule pedidoCompletado
    ( declare (salience 50))
    ( lineaPedido naranjas ?nl manzanas ?ml caquis ?cl uva ?ul )
    ( pedido naranjas ?n manzanas ?m caquis ?c uva ?u )
    ( test (and (= ?nl ?n ) (= ?ml ?m ) (= ?cl ?c ) (= ?ul ?u ) ))
    =>
    ( halt )
    ( printout t"Pedido comletado" crlf)
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


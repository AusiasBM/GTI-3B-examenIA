
(deffacts hechos 
    ( stockPalets naranjas 5 manzanas 3 caquis 7 uva 2 )
    ( pedido naranjas 2 manzanas 4 caquis 1 uva 3 ) 
    ( robot cajas 0 maxPuede 3)
)

(defrule hayBastanteCajas
    ( declare (salience 10))
    ( pedido naranjas ?n manzanas ?m caquis ?c uva ?u )
    ( stockPalets naranjas ?ns manzanas ?ms caquis ?cs uva ?us )
    ( test ( or (> ?n ?ns ) (> ?m ?ms ) (> ?c ?cs ) (> ?u ?us )) )
    =>
    ( halt )
    ( printout t"No hay bastantes cajas para el pedido" crlf)
)

(defrule cogerCajasNaranja
    f1 <- ( robot cajas ?n maxPuede ?p )
    f2 <- ( pedido naranjas ?n manzanas ?m caquis ?c uva ?u )
    ( test (?n <= p ))
    =>
    ( assert ( pedido naranjas (- ?n 1) manzanas ?m caquis ?c uva ?u ) )
)



(defrule depositarCajas

)
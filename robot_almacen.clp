
(deffacts hechos 
    ( max_movi 50)
    ( stockPalets naranjas 5 manzanas 3 caquis 7 uva 2 )
    ( pedido naranjas 0 manzanas 6 caquis 0 uva 0 ) 
    

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

(defrule cogerCajas

)

(defrule depositarCajas

)
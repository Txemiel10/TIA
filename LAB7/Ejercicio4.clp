(deffacts hechos-iniciales
(ini 1))

(deffunction Pedir ()
	(printout t "Introduce un numero : " crlf)
	(bind ?a (read))
	(if(not(integerp ?a))
		then (printout t "Debe ser un numero" crlf)
	else
		(assert (hecho ?a))
		(assert (act 0))
		(assert (suma 0))
	)
)

(defrule inicializa
	(declare (salience 100))
	?f <- (ini ?)
=>
	(Pedir)
	(retract ?f)
)

(defrule sumatorio
	(declare (salience 10))
	?f1 <- (hecho ?a)
	?f2 <- (act ?b)
	?f3 <- (suma ?c)
	(test (> ?a ?b))
=>
	(retract ?f2)
	(retract ?f3)
	(assert (suma (+ ?c ?b)))
	(assert (act (+ 1 ?b)))
)
	
(defrule printYParar
	(declare (salience 5))
	?f1 <- (hecho ?a)
	?f2 <- (act ?b)
	?f3 <- (suma ?c)
	(test (= ?a ?b))
=>
	(printout t "El sumatorio es : "?c crlf)
	(halt)
)
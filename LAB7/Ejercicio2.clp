(defrule maximo
	(declare (salience 10))
	?f1 <- (hecho1 ?a)
	?f2 <- (hecho1 ?b)
	(test (> ?a ?b))
=>
	(retract ?f2))
	
(defrule printYParar
	(declare (salience 5))
	?f <- (hecho1 ?a)
=>
	(printout t "El maximo es : "?a crlf)
	(halt))
	

	
(defrule cuentaAtras
	(declare (salience 10))
	?f <- (hecho1 ?a)
	(test (> ?a 0))
=>
	(printout t ?a crlf)
	(assert (hecho1 (- ?a 1))))
	
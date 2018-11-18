(defrule R1
	(declare (salience 10))
	?f <- (hecho1 $?d ?a ?b $?c)
	(test (> ?a ?b))
=>
	(retract ?f)
	(assert (hecho1 $?d ?a $?c)))
	
(defrule R2
	(declare (salience 10))
	?f <- (hecho1 $?d ?a ?b $?c)
	(test (< ?a ?b))
=>
	(retract ?f)
	(assert (hecho1 $?d ?b $?c)))
	
(defrule printYParar
	(declare (salience 5))
	?f <- (hecho1 ?a)
=>
	(printout t "El maximo es : "?a crlf)
	(halt))
(defrule R1
	(declare (salience 10))
	?f <- (hecho1 $?d ?a ?b $?c)
	(test (> ?a ?b))
=>
	(retract ?f)
	(assert (hecho1 $?d ?b ?a $?c)))
	
	
(defrule printYParar
	(declare (salience 5))
	?f <- (hecho1 $?a)
=>
	(printout t "(ordenado " ?a ")" crlf)
	(halt))
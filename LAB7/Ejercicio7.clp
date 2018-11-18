(deffacts hechos-iniciales
(union ))

(defrule R1
	(declare (salience 100))
	?f <- (union $?d ?a $?x ?b $?c)
	(test (= (str-compare ?a ?b) 0))
=>
	(retract ?f)
	(assert (union $?d ?a $?x $?c)))
	
(defrule R2
	(declare (salience 80))
	?f1 <- (hecho1 ?a $?c)
	?f3 <- (union $?e)

=>
	(retract ?f1)
	(retract ?f3)
	(assert (union  $?e ?a))
	(assert (hecho1 $?c))
)

	
(defrule printYParar
	(declare (salience 5))
	?f <- (union $?a)
=>
	(printout t "(union " ?a ")" crlf)
	(halt))
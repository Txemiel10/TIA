(deffacts hechos-iniciales
(union )
(interseccion ))

(defrule R0
	(declare (salience 120))
	?f <- (hecho1 $?d ?a $?x ?b $?c)
	(test (= (str-compare ?a ?b) 0))
=>
	(retract ?f)
	(assert (hecho1 $?d ?a $?x $?c))
)

(defrule R1
	(declare (salience 100))
	?f <- (union $?d ?a $?x ?b $?c)
	?f2 <- (interseccion $?y)
	(test (= (str-compare ?a ?b) 0))
=>
	(retract ?f)
	(retract ?f2)
	(assert (union $?d ?a $?x $?c))
	(assert (interseccion $?y ?a)))
	
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
	?f <- (interseccion $?a)
=>
	(printout t "(interseccion " ?a ")" crlf)
	(halt))
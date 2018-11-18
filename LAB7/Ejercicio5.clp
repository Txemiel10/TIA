(deffacts hechos-iniciales
(resultado 1))

(defrule R1
	(declare (salience 20))
	?f1 <- (hecho1 ?a)
	?f2 <- (resultado ?b)
	(test (= ?a 0))
=>
	(printout t "(resultado " ?b ")" crlf)
	(retract ?f1)	
	(retract ?f2)	
)

(defrule R2
	(declare (salience 10))
	?f1 <- (hecho1 ?a)
	?f2 <- (resultado ?b)
=>
	(retract ?f1)	
	(retract ?f2)
	(assert (resultado (* ?b ?a)))
	(assert (hecho1 (- ?a 1)))
)

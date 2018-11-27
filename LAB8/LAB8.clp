(deffacts hechos-iniciales
(Jarra4 0 Jarra3 0)
)

(defrule estadoActual
	(declare (salience 120))
	?f <- (estadoActual $?a)
=>
	(printout t $?a crlf)
	(retract ?f)
)

(deffunction mover2de3a4 (?a)
		(if (> ?a 0)
		then
			(printout t "La jarra de 4l ha sido vaciada al completo" crlf)
			(printout t "Contenito de jarra 4l -> 0 l , contenido de jarra 3l -> 2 l" crlf)			
		)				
		(assert (Jarra4 2 Jarra3 0))
		(assert (estadoActual Contenito de jarra 4l -> 2 l , contenido de jarra 3l -> 0 l))
		(printout t "Se ha vaciado el contenido de la jarra de 3l en la jarra de 4l" crlf)
		
)

(defrule 2en3
	(declare (salience 110))
	?f <- (Jarra4 ?a Jarra3 ?b)
	(test (= ?b 2))
=>
	(mover2de3a4 ?a)
	(retract ?f)
)

(defrule final
	(declare (salience 100))
	?f <- (Jarra4 ?a Jarra3 ?b)
	(test (= ?a 2))
=>
	(printout t "Objetivo cumplido" crlf)
	(halt)
)

(defrule llenar4entera
	(declare (salience 15))
	?f <- (Jarra4 ?a Jarra3 ?b)
	(test (< ?a 4))
=>
	(printout t "La jarra de 4l ha sido llenada al completo" crlf)
	(retract ?f)
	(assert (Jarra4 4 Jarra3 ?b))
	(assert (estadoActual Contenito de jarra 4l -> 4 l , contenido de jarra 3l -> ?b l))
)

(defrule llenar3entera
	(declare (salience 95))
	?f <- (Jarra4 ?a Jarra3 ?b)
	(test (< ?b 3))
=>
	(printout t "La jarra de 3l ha sido llenada al completo" crlf)
	(retract ?f)
	(assert (Jarra4 ?a Jarra3 3))
	(assert (estadoActual Contenito de jarra 4l -> ?a l, contenido de jarra 3l -> 3 l))
)

(defrule vaciar4entera
	(declare (salience 50))
	?f <- (Jarra4 ?a Jarra3 ?b)
	(test (> ?a 0))
=>
	(printout t "La jarra de 4l ha sido vaciada al completo" crlf)
	(retract ?f)
	(assert (Jarra4 0 Jarra3 ?b))
	(assert (estadoActual Contenido de jarra 4l -> 0 l , contenido de jarra 3l -> ?b l))
)

(defrule vaciar3entera
	(declare (salience 15))
	?f <- (Jarra4 ?a Jarra3 ?b)
	(test (> ?b 0))
=>
	(printout t "La jarra de 3l ha sido vaciada al completo" crlf)
	(retract ?f)
	(assert (Jarra4 ?a Jarra3 0))
	(assert (estadoActual Contenito de jarra 4l -> ?a , contenido de jarra 3l -> 0l))
)

(deffunction vaciar4en3 (?a ?b)
		(if (> ?a (- 3 ?b))
		then
			(assert (Jarra4 (- ?a (- 3 ?b)) Jarra3 3))
			(assert (estadoActual Contenito de jarra 4l -> (- ?a (- 3 ?b)) l , contenido de jarra 3l -> 3 l))
		else
			(assert (Jarra4 0 Jarra3 (+ ?a ?b)))
			(assert (estadoActual Contenito de jarra 4l -> 0 l , contenido de jarra 3l -> (+ ?a ?b) l))
			
		)				
		(printout t "Se ha vaciado el contenido de la jarra de 4l en la jarra de 3l" crlf)
)

(deffunction vaciar3en4 (?a ?b)
		(if (> ?b (- 4 ?a))
		then
			(assert (Jarra4 4 Jarra3 (- ?b (- 4 ?a))))
			(assert (estadoActual Contenito de jarra 4l -> 4 l , contenido de jarra 3l -> (- ?b (- 4 ?a)) l))
		else
			(assert (Jarra4 (+ ?a ?b) Jarra3 0))
			(assert (estadoActual Contenito de jarra 4l -> (+ ?a ?b)l , contenido de jarra 3l -> 0l))
			
		)				
		(printout t "Se ha vaciado el contenido de la jarra de 3l en la jarra de 4l" crlf)
)


(defrule vaciarJarra4enJarra3
	(declare (salience 5))
	?f <- (Jarra4 ?a Jarra3 ?b)
	(test (and (> ?a 0) (< ?b 3)))
=>
	(retract ?f)
	(vaciar4en3 ?a ?b)
)

(defrule vaciarJarra3enJarra4
	(declare (salience 90))
	?f <- (Jarra4 ?a Jarra3 ?b)
	(test (and (> ?b 0) (< ?a 4)))
=>
	(retract ?f)
	(vaciar3en4 ?a ?b)
)



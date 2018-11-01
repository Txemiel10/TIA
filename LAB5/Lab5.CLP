; el espacio de estados es un multicampo de 4 campos
; 1º: posicion del granjero (0:IZQUIERDA/1:DERECHA)
; 2º: posicion de la lechuga (0:IZQUIERDA/1:DERECHA)
; 3º: posicion de la cabra (0:IZQUIERDA/1:DERECHA)
; 4º: posicion del puma (0:IZQUIERDA/1:DERECHA)

(defglobal ?*estInicial* = "0 0 0 0")
(defglobal ?*estFinales* = (create$ "1 1 1 1"))
(defglobal ?*estVisitados* = (create$))
(defglobal ?*estImposibles* = (create$ "0 1 1 1" "0 1 1 0" "0 0 1 1" "1 0 0 0" "1 1 0 0" "1 0 0 1"))	
(defglobal ?*recorrido* = (create$ ""))


;Devuelven el lugar en el que se encuentran (izq o dch) 
(deffunction posGranjero (?est)
	(return (nth$ 1 (explode$ ?est)))
)
(deffunction posLechuga (?est)
	(return (nth$ 2 (explode$ ?est)))
)
(deffunction posCabra (?est)
	(return (nth$ 3 (explode$ ?est)))
)
(deffunction posPuma (?est)
	(return (nth$ 4 (explode$ ?est)))
)

;devuelve si se encuentran en el mismo lado que el granjero
(deffunction juntosGL(?est)
		(if (eq (posGranjero ?est) (posLechuga ?est))
			then 
				(return TRUE)
		else 
				(return FALSE)
		)
)
(deffunction juntosGC(?est)
		(if (eq (posGranjero ?est) (posCabra ?est))
			then 
				(return TRUE)
		else 
				(return FALSE)
		)
)	
(deffunction juntosGP(?est)
		(if (eq (posGranjero ?est) (posPuma ?est))
			then 
				(return TRUE)
		else 
				(return FALSE)
		)
)	
		
				

;Cruza el rio el granjero
(deffunction movG (?est)
	(switch (posGranjero ?est)															
		(case 0 then					;Si se encuentra en la izquierda -> derecha
			(return (implode$ (replace$ (explode$ ?est) 1 1 1)))	
		)	
		(case 1 then					;Si se encuentra en la derecha -> izquierda
			(return (implode$ (replace$ (explode$ ?est) 1 1 0)))
		)
	)
)


;Cruza el rio el granjero y la lechuga
(deffunction movGL (?est)
	(switch (posGranjero ?est)
			;Si se encuentra en la izquierda -> derecha
		(case 0 then				
			(return (implode$ (replace$ (replace$ (explode$ ?est) 1 1 1) 2 2 1)))
		)
			;Si se encuentra en la derecha -> izquierda
		(case 1 then
			(return (implode$ (replace$ (replace$ (explode$ ?est) 1 1 0) 2 2 0)))
		)
	)	
)

;Cruza el rio el granjero y la cabra
(deffunction movGC (?est)	
	(switch (posGranjero ?est)
			;Si se encuentra en la izquierda -> derecha
		(case 0 then
			(return (implode$ (replace$ (replace$ (explode$ ?est) 1 1 1) 3 3 1)))
		)
			;Si se encuentra en la derecha -> izquierda
		(case 1 then
			(return (implode$ (replace$ (replace$ (explode$ ?est) 1 1 0) 3 3 0)))
		)
	)
)

;Cruza el rio el granjero y el puma
(deffunction movGP (?est)
	(switch (posGranjero ?est)
			;Si se encuentra en la izquierda -> derecha
		(case 0 then
			(return (implode$ (replace$ (replace$ (explode$ ?est) 1 1 1) 4 4 1)))
		)
			;Si se encuentra en la derecha -> izquierda
		(case 1 then
			(return (implode$ (replace$ (replace$ (explode$ ?est) 1 1 0) 4 4 0)))
		)
	)
)

(deffunction sePuede (?est)
	(if (not(member$ ?est ?*estImposibles*)) 
	then
		(return FALSE)
	else
		(return TRUE)
	)
)

(deffunction estaVisitado (?est)
	(if (not(member$ ?est ?*estVisitados*)) 
	then
		(return FALSE)
	else
		(return TRUE)
	)
)

(deffunction haAcabado (?est)
	(if (not(member$ ?est ?*estFinales*)) 
	then
		(return FALSE)
	else
		(return TRUE)
	)
)

(deffunction EscribirG(?est)
	(switch (posGranjero ?est)
			;Si se encuentra en la izquierda -> derecha
		(case 0 then				
			(printout t "El granjero pasa al lado derecho" crlf)
		)
			;Si se encuentra en la derecha -> izquierda
		(case 1 then
			(printout t "El granjero vuelve al lado izquierdo" crlf)
		)
	)	
)
(deffunction EscribirGL(?est)
	(switch (posGranjero ?est)
			;Si se encuentra en la izquierda -> derecha
		(case 0 then				
			(printout t "El granjero y la lechuga pasan al lado derecho" crlf)			
		)
			;Si se encuentra en la derecha -> izquierda
		(case 1 then
			(printout t "El granjero y la lechuga vuelven al lado izquierdo" crlf)
		)
	)	
)
(deffunction EscribirGC(?est)
	(switch (posGranjero ?est)
			;Si se encuentra en la izquierda -> derecha
		(case 0 then				
			(printout t "El granjero y la cabra pasan al lado derecho" crlf)			
		)
			;Si se encuentra en la derecha -> izquierda
		(case 1 then
			(printout t "El granjero y la cabra vuelven al lado izquierdo" crlf)
		)
	)	
)
(deffunction EscribirGP(?est)
	(switch (posGranjero ?est)
			;Si se encuentra en la izquierda -> derecha
		(case 0 then				
			(printout t "El granjero y la puma pasan al lado derecho" crlf)		
		)
			;Si se encuentra en la derecha -> izquierda
		(case 1 then
			(printout t "El granjero y la puma vuelven al lado izquierdo" crlf)
		)
	)	
)


(deffunction elimPrimero (?aux)
	(return (delete$ ?aux 1 1))
)
(deffunction calcularCoste()
	(printout t "El coste de ha sido " (str-length (nth$ 1 ?*recorrido*)) " " crlf)
)

;Metodo de Escritura Final

(deffunction escribirFinal(?arbol)
	(printout t "- - - - - - - - - - - - - - - - - - - - - - - - - - - - " crlf)
	(printout t "Todos han pasado el rio " crlf)
	(printout t "El camino ha seguir ha sido (" (nth$ 1 ?*recorrido*) ") " crlf)
	(calcularCoste)
)


;Metodo principal
(deffunction iniciar ()

  (printout t "- - - - - - - - - - - - - - - - - - - - - - - - - - - - " crlf)
  (printout t "Se realizara una busqueda en profundidad para llevar a cabo esta tarea" crlf)  
  (printout t "- - - - - - - - - - - - - - - - - - - - - - - - - - - - " crlf) 
  (printout t "Empiezan los viajes" crlf)
  (bind ?arbol (create$ ?*estInicial*))
  (bind ?*estVisitados* (insert$ ?*estVisitados* (+ 1 (length$ ?*estVisitados*)) ?*estInicial*))
  (while (not (haAcabado (nth$ 1 ?arbol)))
    (printout t ?arbol crlf)
    (bind ?nodoActual (nth$ 1 ?arbol))
    (bind ?auxPrueba (movG ?nodoActual))
    (if (not (or (estaVisitado ?auxPrueba)(sePuede ?auxPrueba))) 	
		then
			(bind ?arbol (insert$ ?arbol 2 ?auxPrueba))
			(bind ?*recorrido* (insert$ ?*recorrido* 2 (str-cat (nth$ 1 ?*recorrido*) G)))
			(bind ?*estVisitados* (insert$ ?*estVisitados* (+ 1 (length$ ?*estVisitados*)) ?auxPrueba))
			(EscribirG ?nodoActual)
	
	)
   (bind ?auxPrueba (movGL ?nodoActual))
    (if (not (or (eq (juntosGL ?nodoActual) FALSE) (estaVisitado ?auxPrueba)(sePuede ?auxPrueba))) 	
		then
			(bind ?arbol (insert$ ?arbol 2 ?auxPrueba))
			(bind ?*recorrido* (insert$ ?*recorrido* 2	  (str-cat (nth$ 1 ?*recorrido*) L)))
			(bind ?*estVisitados* (insert$ ?*estVisitados* (+ 1 (length$ ?*estVisitados*)) ?auxPrueba))
			(EscribirGL ?nodoActual)
    )
	
	(bind ?auxPrueba (movGC ?nodoActual))
    (if (not (or (eq (juntosGC ?nodoActual) FALSE) (estaVisitado ?auxPrueba)(sePuede ?auxPrueba))) 	
		then
			(bind ?arbol (insert$ ?arbol 2 ?auxPrueba))
			(bind ?*recorrido* (insert$ ?*recorrido* 2	  (str-cat (nth$ 1 ?*recorrido*) C)))
			(bind ?*estVisitados* (insert$ ?*estVisitados* (+ 1 (length$ ?*estVisitados*)) ?auxPrueba))
			(EscribirGC ?nodoActual)
    )
	
	(bind ?auxPrueba (movGP ?nodoActual))
    (if (not (or (eq (juntosGP ?nodoActual) FALSE) (estaVisitado ?auxPrueba)(sePuede ?auxPrueba))) 	
		then
			(bind ?arbol (insert$ ?arbol 2 ?auxPrueba))
			(bind ?*recorrido* (insert$ ?*recorrido* 2	  (str-cat (nth$ 1 ?*recorrido*) P)))
			(bind ?*estVisitados* (insert$ ?*estVisitados* (+ 1 (length$ ?*estVisitados*)) ?auxPrueba))
			(EscribirGP ?nodoActual)
    )
	
    
    (bind ?arbol (elimPrimero ?arbol))
    (bind ?*recorrido* (elimPrimero ?*recorrido*))
  )
	(printout t "¡¡('"(nth$ 1 ?arbol)"')!!" crlf)
	(escribirFinal ?arbol)
)
; el espacio de estados es un multicampo de 3 campos binarios
; 1º: estado de la habitación de la izquierda (0: limpia/ 1: sucia)
; 2º: estado de la habitación de la derecha   (0: limpia/ 1: sucia)
; 3º: posición de la aspiradora (0: derecha/ 1: izquierda)
; el 1 recuerda a una I y el 0 a una D

(defglobal ?*estInicial* = "0 0 0")
(defglobal ?*estFinales* = (create$ "0 0 0" "0 0 1"))
(defglobal ?*estVisitados* = (create$))
(defglobal ?*recorrido* = (create$ ""))


(deffunction habAspiradora (?est)
	(return (nth$ 3 (explode$ ?est)))
)

(deffunction limpiar (?est)
	(switch (habAspiradora ?est)
		(case 0 then
			(return (implode$ (replace$ (explode$ ?est) 2 2 0)))
		)
		(case 1 then
		(return (implode$ (replace$ (explode$ ?est) 1 1 0)))
		)
	)
)

(deffunction estaVisitado (?est)
	(if (member$ ?est ?*estVisitados*) then
		(return TRUE)
	else
		(return FALSE)
	)
)

(deffunction haAcabado (?est)
	(if (member$ ?est ?*estFinales*) then
		(return TRUE)
	else
		(return FALSE)
	)
)

(deffunction movIzq (?est)
	(return (implode$ (replace$ (explode$ ?est) 3 3 1)))
)

(deffunction movDer (?est)
	(return (implode$ (replace$ (explode$ ?est) 3 3 0)))
)



;Metodo para introducir los datos que deseamos en el programa

(deffunction inputEstados ()
	(bind ?terminado FALSE)
	(while (eq ?terminado FALSE)
		(bind ?input (read))
		(bind ?terminado (or (eq 0 ?input) (eq 1 ?input)))
		(if (eq ?terminado FALSE) then
			(printout t "El valor solo puede ser 0 o 1, introduzcalo de nuevo " crlf)
		)
	)
  (return ?input)
)


(deffunction inicializarM ()
	(printout t "¿Como está la habitacion de la izquierda? 0:limpia / 1:sucia" crlf)
	(bind ?habIzq (inputEstados))
	(printout t "¿Como está la habitacion de la derecha? 0:limpia / 1:sucia" crlf)
	(bind ?habDch (inputEstados))
	(printout t "Introduzca donde se encuentra la aspiradora 0:derecha / 1:izquierda" crlf)
	(bind ?aspiradora (inputEstados))
	(bind ?*estInicial* (implode$ (create$ ?habIzq ?habDch ?aspiradora)))
	(bind ?*estVisitados* (create$))
	(bind ?*recorrido* (create$ ""))
)

(deffunction inicializarA ()
	(bind ?*estInicial* (implode$ (create$ (random 0 1) (random 0 1) (random 0 1))))
	(bind ?*estVisitados* (create$))
	(bind ?*recorrido* (create$ ""))
	(printout t "El estado inicial es (" ?*estInicial* "). " crlf)
  
)

(deffunction inicializar ()
	(printout t "¿Como desea inicializar el programa? M:Manual / A:Aleatorio" crlf)
	(bind ?terminado FALSE)
	(while (eq ?terminado FALSE)
		(bind ?input (read))
		(bind ?terminado (or (eq M ?input) (eq A ?input)))
		(if (eq ?terminado FALSE) then
			(printout t "El valor solo puede ser M o A, introduzcalo de nuevo  " crlf)
		)
	)
	(if (eq ?input M)
		then (inicializarM)
	else (inicializarA)
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
	(printout t "LIMPIEZA FINALIZADA " crlf)
	(printout t "Se ha llegado al estado (" (nth$ 1 ?arbol) ") " crlf)
    	(printout t "Habiendo comenzado en el estado inicial ("  ?*estInicial*  ") " crlf)
	(printout t "Siendo el camino seguido (" (nth$ 1 ?*recorrido*) ") " crlf)
	(calcularCoste)
)

(deffunction iniciar ()
  (inicializar)
  (printout t "- - - - - - - - - - - - - - - - - - - - - - - - - - - - " crlf)
  (printout t "Se realizara una busqueda en anchura para llevar a cabo esta tarea" crlf)  
  (printout t "- - - - - - - - - - - - - - - - - - - - - - - - - - - - " crlf) 
  (printout t "COMIENZA LA LIMPIEZA  " crlf)
  (bind ?arbol (create$ ?*estInicial*))
  (bind ?*estVisitados* (insert$ ?*estVisitados* (+ 1 (length$ ?*estVisitados*)) ?*estInicial*))
  (while (not (haAcabado (nth$ 1 ?arbol)))
    (printout t ?arbol crlf)
    (bind ?nodoActual (nth$ 1 ?arbol))
    (bind ?auxPrueba (limpiar ?nodoActual))
    (if (not (estaVisitado ?auxPrueba)) then
    	(bind ?arbol (insert$ ?arbol (+ 1 (length$ ?arbol)) ?auxPrueba))
	(bind ?*estVisitados* (insert$ ?*estVisitados* (+ 1 (length$ ?*estVisitados*)) ?auxPrueba))
	(bind ?*recorrido* (insert$ ?*recorrido* (+ 1 (length$ ?*recorrido*)) (str-cat (nth$ 1 ?*recorrido*) A)))
    )
    (bind ?auxPrueba (movDer ?nodoActual))
    (if (not (estaVisitado ?auxPrueba)) then
	(bind ?arbol (insert$ ?arbol (+ 1 (length$ ?arbol)) ?auxPrueba))
	(bind ?*estVisitados* (insert$ ?*estVisitados* (+ 1 (length$ ?*estVisitados*)) ?auxPrueba))
     	(bind ?*recorrido* (insert$ ?*recorrido* (+ 1 (length$ ?*recorrido*)) (str-cat (nth$ 1 ?*recorrido*) D)))
    )
    (bind ?auxPrueba (movIzq ?nodoActual))
    (if (not (estaVisitado ?auxPrueba)) then
	(bind ?arbol (insert$ ?arbol (+ 1 (length$ ?arbol)) ?auxPrueba))
	(bind ?*estVisitados* (insert$ ?*estVisitados* (+ 1 (length$ ?*estVisitados*)) ?auxPrueba))
      	(bind ?*recorrido* (insert$ ?*recorrido* (+ 1 (length$ ?*recorrido*)) (str-cat (nth$ 1 ?*recorrido*) I)))
    )
    (bind ?*recorrido* (elimPrimero ?*recorrido*))
    (bind ?arbol (elimPrimero ?arbol))
  )
	(printout t "¡¡('"(nth$ 1 ?arbol)"')!!" crlf)
	(escribirFinal ?arbol)
)
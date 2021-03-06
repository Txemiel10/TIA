(deffunction dentroDelRango(?a ?b)
	(bind ?fallo 0)
	(if (not(and (integerp ?a)(integerp ?b)))
		then (printout t "Debe introducir dos numeros como parametros" crlf)
	else 
		(while (= ?fallo 0)
			(printout t "Introduce otro numero" crlf)
			(bind ?c (read))
			(if (not(integerp ?c))
				then (printout t "Debe ser un numero" crlf)
			else
				(if (or (and (>= ?c ?b) (<= ?c ?a)) (and (<= ?c ?b) (>= ?c ?a)))
					then 	(bind ?fallo 1)
						(return ?c)
				else (printout t "En numero no esta dentro del rango" crlf)
				)
			)
	  	)
	)
)	
(deffunction acertijo(?a ?b)
	(bind ?fallo 0)
	(if (not(and (integerp ?a)(integerp ?b)))
		then (printout t "Debe introducir dos numeros como parametros" crlf)
	else 
		(bind ?d (random ?a ?b))
		(while (= ?fallo 0)
			(printout t "Introduce otro numero" crlf)
			(bind ?c (read))
			(if (not(integerp ?c))
				then (printout t "Debe ser un numero" crlf)
			else
				(if (= ?c ?d)	
				then		(bind ?fallo 1)
						(printout t "‘‘‘Has acertado!!! Era el " crlf)
				(return ?d)

				else 		(if (not(or (and (>= ?c ?b) (<= ?c ?a)) (and (<= ?c ?b) (>= ?c ?a))))
						then
							(printout t "El numero no esta en el rango  ―\_(¦_¦)_/― " crlf)
						else
							(printout t "Siga jugando " crlf) 
						)
				)
			)
	  	)
	)
)	
(deffunction mcd(?a ?b)
	(if (not(and (integerp ?a)(integerp ?b)))
		then (printout t "Debe introducir dos numeros como parametros" crlf)
	else 
		(if (or (< ?a 0) (< ?b 0))
			then 	(printout t "Debe introducir dos numeros positivos como parametros" crlf)
			(return FALSE)
		else
			(if (= ?a ?b)
				then (return ?a)
			else
				(if (< ?a ?b)
					then (return (mcd ?a (- ?b ?a)))
				else
					(return (mcd (- ?a ?b) ?b))
				)
			)
	 	)
	)
)

(deffunction mcm(?a ?b)
	(if (not(and (integerp ?a)(integerp ?b)))
		then (printout t "Debe introducir dos numeros como parametros" crlf)
	else 
		(if (or (< ?a 0) (< ?b 0))
			then 	(printout t "Debe introducir dos numeros positivos como parametros" crlf)
			(return FALSE)
		else
			(bind ?c (* ?a ?b))
			(bind ?d (mcd ?a ?b))
			(return (integer(/ ?c ?d)))
		)
	)
)

(deffunction mes (?a)
	(if(not(integerp ?a))
		then (printout t "El parametro debe ser un numero" crlf)
		     (return FALSE)
	else	(if (= 2 ?a)
				then (printout t "28, 29 si es bisiesto" crlf)
			else	(if (or (= 4 ?a) (= 6 ?a) (= 9 ?a) (= 10 ?a))
						then (printout t "30" crlf)
					else 	(if (or (> ?a 12) (< ?a 1))
								then (printout t "Debe ser entre 1 y 12" crlf)
									  (return FALSE)
							else (printout t "31" crlf)
							)
					)
			)
	)
)

(deffunction diferencia (?a ?b)
	(bind ?repetido 0)
	(bind $?c (create$))
	(progn$ (?var1 $?a)
		(progn$ (?var2 $?b)
			(if (not(integerp ?var1))
			then
				(if (not(integerp ?var2))
				then
					(if (= 0 (str-compare ?var1 ?var2))
					then
						(bind ?repetido 1)
					)
				)
			else
				(if (integerp ?var2)
				then
					(if (= ?var1 ?var2)
					then
						(bind ?repetido 1)
					)
				)
			)
		)
		(if (= 0 ?repetido)
		then
			(bind $?c (create$ $?c ?var1))			
		)
		(bind ?repetido 0)
	)
	(return $?c)
)


(deffunction concatenacion (?a ?b) 
	(bind $?c (create$ $?a $?b))
	(return $?c)
)

(deffunction sustituir (?a ?b $?c) 
	(bind ?i 1)
	(if (not(integerp ?a))
	then
		(progn$ (?var $?c)
			(if (not(integerp ?var))
			then 
				(if (= 0 (str-compare ?a ?var))
				then 
					(bind $?c (replace$ $?c ?i ?i ?b))
				)
			)
			(bind ?i (+ ?i 1))
		)
	else
		(progn$ (?var $?c)
			(if (integerp ?var)
			then 
				(if (= ?a ?var)
				then 
					(bind $?c (replace$ $?c ?i ?i ?b))
				)			
			)
			(bind ?i (+ ?i 1))
		)
	)	
	(return $?c)
)

(deffunction cartesiano (?a ?b)
	(bind $?c (create$))
	(progn$ (?i $?a)
		(progn$ (?j $?b)
			(bind $?c (concatenacion $?c (create$ ?i)))
			(bind $?c (concatenacion $?c (create$ ?j)))
		)
	)
	(return $?c)
)

(deffunction escalar (?a ?b)
	(bind ?resultado 0)
	(bind ?i 1)
	(bind ?vcontrol 0)
	(bind ?p2 0)
	(progn$ (?p1 $?a)
		(if (not(integerp ?p1))
		then 
			(return "todos los parametros deben ser numeros")
		else
			(while (= ?vcontrol 0)
				(bind ?p2 (nth$ ?i $?b))
				(if (not(integerp ?p2))
				then 
					(return "todos los parametros deben ser numeros")
				else 
					(bind ?vcontrol 1)
				)
			)
		)
		(bind ?i (+ ?i 1))
		(bind ?resultado (+ ?resultado (* ?p1 ?p2)))
		(bind ?vcontrol 0)
	)
	(return ?resultado)
)

(deffunction unico (?a)
	(bind ?repetido 0)
	(progn$ (?var1 $?a)
		(if (not(integerp ?var1))
		then 
			(return "Todos los parametros deben ser numeros")
		else
			(if (> ?var1 (length$ $?a))
			then
				(return "FALSE")
			else
				(progn$ (?var2 $?a)
					(if (not(integerp ?var2))
					then 
						(return "Todos los parametros deben ser numeros")
					else
						(if (= ?var1 ?var2)
						then
							(bind ?repetido (+ ?repetido 1))
						)
						(if (= ?repetido 2)
						then
							(return "FALSE")
						)
					)
				)
			(bind ?repetido 0)
			)
		)
	)
	(return "TRUE")
)

(deffunction esPrimo (?a)
	(if(not(integerp ?a))
		then (printout t "El parametro debe ser un numero" crlf)
			(return FALSE)
	else
		(bind ?b 0)
		(bind ?c 1)
		(while (< ?c ?a)
			(if (= (mod ?a ?c) 0)
				then (bind ?b (+ ?b 1))
			)
		(bind ?c (+ ?c 1))
		)
		(if(= ?b 1)
			then (return TRUE)
		else (return FALSE)
		)
	)
)

(deffunction esCapicua (?a)
	(if(not(integerp ?a))
		then (printout t "El parametro debe ser un numero" crlf)
			(return FALSE)
	else

		(if(< ?a 1)
		then (bind ?a (* ?a -1))
		)
		(bind ?b 0)
		(bind ?c ?a)
		(while (> ?c 9)
			(bind ?b (+ (mod ?c 10) (* ?b 10)))
			(bind ?c (integer(/ ?c 10)))
		)
		(bind ?b (+ ?c (* ?b 10)))	
		(if (= ?a ?b)
			then (return TRUE)
		else (return FALSE)
		)
		
	)
)

(deffunction num_primos_y_capicua ()
	(printout t "Introduce numero" crlf)
	(bind ?a (read))
	(if(not(integerp ?a))
		then (printout t "Debe ser un numero" crlf)
	else
		(if (< ?a 0)
		then (printout t "El numero no puede ser negativo, lo tomaremos como positivo" crlf)
		     (bind ?a (* ?a -1))			
		)
		(bind ?b 1)
		(loop-for-count ?a
			(if (and (esPrimo ?b) (esCapicua ?b))
				then (printout t ?b crlf)
			)
		(bind ?b (+ ?b 1))
		)
	(return TRUE)
	)
)


(deffunction num_magico2 (?a)
	(if(not(integerp ?a))
		then (printout t "Debe ser un numero" crlf)
	else
		(if(> ?a 9)
		then (bind ?b ?a)
			 (bind ?c 0)
			 (bind ?d 0)
			 (while (> ?b 9)
				(bind ?c (mod ?b 10))
				(bind ?b (integer(/ ?b 10)))
				(bind ?d (+ ?c ?d))
				)
			(bind ?d (+ ?b ?d))
			(num_magico2 ?d)
		else
			(return ?a)
		)
	)
)	

(deffunction num_magico ()
	(printout t "Introduce numero" crlf)
	(bind ?a (read))
	(if(not(integerp ?a))
		then (printout t "Debe ser un numero" crlf)
	else
		(if (< ?a 0)
		then
			(bind ?a (* ?a -1))
		)
		(if(> ?a 9)
		then (bind ?b ?a)
			 (bind ?c 0)
			 (bind ?d 0)
			 (while (> ?b 9)
				(bind ?c (mod ?b 10))
				(bind ?b (integer(/ ?b 10)))
				(bind ?d (+ ?c ?d))
				)
			(bind ?d (+ ?b ?d))
			(num_magico2 ?d)
		else
			(return ?a)
		)
	)
)	

(deffunction sumaHasta (?a)
	(bind ?suma 0)
	(bind ?contador 1)
	(bind ?acum 1)
	(bind ?acum2 1)
	(if(not(integerp ?a))
	 then (printout t "El parametro debe ser un numero" crlf)
		(return FALSE)
	else
		(while (< ?contador (- ?a 1))
			(bind ?suma (+ 1 ?contador))
			(bind ?acum (+ ?suma ?acum2))
			(bind ?acum2 ?acum)
			(bind ?contador ?suma)
		)
		(bind ?acum (+ ?a ?acum2))
	)
	(return ?acum)

)


(deffunction EsMedio (?a)
	(if(not(integerp ?a))
	 then (printout t "El parametro debe ser un numero" crlf)
		(return FALSE)
	else
		(bind ?b (- (sumaHasta ?a) ?a))
		(bind ?c 0)
		(bind ?d 1)
		(while (< ?c ?b)
			(bind ?c (+ ?a ?d ?c))
			(if (= ?c ?b)
				then (return TRUE)
			else (if (> ?c ?b)
					then (return FALSE)
				 else (bind ?d (+ ?d 1))
				 )
			)
		)
	)
)

(deffunction numeros_medios_hasta12000 ()
	(bind ?a 1)
	(loop-for-count 12000
		(if (eq (EsMedio ?a) TRUE)
			then (printout t ?a crlf)
		)
	(bind ?a (+ ?a 1))
	)
)

(deffunction programaPrueba ()
	(printout t "--> Programa de prueba <--" crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(dentroDelRango 3 6) --> 2 No 4 Si" crlf)
	(dentroDelRango 3 6)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(acertijo 3 6)" crlf)
	(printout t "Prueba hasta acertar" crlf)
	(acertijo 3 6)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(mcd 3 6)-->3" crlf)
	(printout t "(mcd 3 6)" crlf)
	(printout t "(mcd 38 63)-->1" crlf)
	(printout t (mcd 38 63) crlf)
	(printout t "(mcd a b)-->"Debe introducir dos numeros como parametros"" crlf)
	(printout t (mcd a b) crlf)
	(printout t "(mcd 64 -63)-->Debe introducir dos numeros positivos como parametros FALSE" crlf)
	(printout t (mcd 64 -63) crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(mcm 72 50)-->1800" crlf)
	(printout t (mcm 72 50) crlf)
	(printout t "(mcm a b)-->"Debe introducir dos nΓΊmeros como parametros"" crlf)
	(printout t (mcm a b) crlf)
	(printout t "(mcm 64 -63)-->Debe introducir dos numeros positivos como parametros FALSE " crlf)
	(printout t (mcm 64 -63) crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(mes 1)-->31" crlf)
	(printout t (mes 1) crlf)
	(printout t "(mes 2)--> 28, 29 si es bisiesto " crlf)
	(printout t (mes 2) crlf)
	(printout t "(mes -2)--> Numero tiene que ser positivo" crlf)
	(printout t (mes -2) crlf)
	(printout t "(mes a)--> Tiene que ser un numero" crlf)
	(printout t (mes a) crlf)
	(printout t "(mes 23)--> Tiene que ser un numero entre 1 y 12" crlf)
	(printout t (mes 23) crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(diferencia (create$ a b c d)(create$ b c e)) β (a d)" crlf)
	(printout t (diferencia (create$ a b c d)(create$ b c e)) crlf)
	(printout t "(diferencia (create$ a 3 4 c d)(create$ b 3 c e)) β (a 4 d)" crlf)
	(printout t (diferencia (create$ a 3 4 c d)(create$ b 3 c e)) crlf)
	(printout t "(diferencia (create$ a 3 4 -4 c d)(create$ b 3 -4 c e)) β (a 4 d)" crlf)
	(printout t (diferencia (create$ a 3 4 -4 c d)(create$ b 3 -4 c e)) crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(concatenacion (create$ a b c d)(create$ b c e)) β (a b c d b c e)" crlf)
	(printout t (concatenacion (create$ a b c d)(create$ b c e)) crlf)
	(printout t "(concatenacion (create$ a -8 c d)(create$ 2 4 e)) β (a -8 c d 2 4 e)" crlf)
	(printout t (concatenacion (create$ a -8 c d)(create$ 2 4 e)) crlf)
	(printout t "(diferencia (create$ a 3 4 -4 c d)(create$ b 3 -4 c e)) β (a 4 d)" crlf)
	(printout t (diferencia (create$ a 3 4 -4 c d)(create$ b 3 -4 c e)) crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(sustituir a b (create$ b a e)) β (b b e)" crlf)
	(printout t (sustituir a b (create$ b a e)) crlf)
	(printout t "(sustituir -5 b (create$ b -5 e)) β (b b e)" crlf)
	(printout t (sustituir -5 b (create$ b -5 e)) crlf)
	(printout t "(sustituir a -5 (create$ b a e)) β (b -5 e)" crlf)
	(printout t (sustituir a -5 (create$ b a e)) crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(cartesiano (create$ a b)(create$ c d)) β (a c a d b c b d)" crlf)
	(printout t (cartesiano (create$ a b)(create$ c d)) crlf)
	(printout t "(cartesiano (create$ -5 b)(create$ 8 d)) β (-5 8 -5 d b 8 b d)" crlf)
	(printout t (cartesiano (create$ -5 b)(create$ 8 d)) crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(escalar (create$ 2 3)(create$ 4 5)) β 2*4+3*5 β 23" crlf)
	(printout t (escalar (create$ 2 3)(create$ 4 5)) crlf)
	(printout t "(escalar (create$ -2 3)(create$ 4 5)) β -2*4+3*5 β 7" crlf)
	(printout t (escalar (create$ -2 3)(create$ 4 5)) crlf)
	(printout t "(escalar (create$ 2 3)(create$ -4 5)) β 2*4+3*5 β 7" crlf)
	(printout t (escalar (create$ 2 3)(create$ -4 5)) crlf)
	(printout t "(escalar (create$ b 3)(create$ 4 5)) β Tienen que ser numeros" crlf)
	(printout t (escalar (create$ b 3)(create$ 4 5)) crlf)
	(printout t "(escalar (create$ 2 3)(create$ b 5)) β Tienen que ser numeros" crlf)
	(printout t (escalar (create$ 2 3)(create$ b 5)) crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(unico (create$ 1 3 4 2)) β TRUE" crlf)
	(printout t (unico (create$ 1 3 4 2)) crlf)
	(printout t "(unico (create$ 1 3 7 2)) β FALSE" crlf)
	(printout t (unico (create$ 1 3 7 2)) crlf)
	(printout t "(unico (create$ 1 3 a 2)) β Todos los parametros deben ser numeros" crlf)
	(printout t (unico (create$ 1 3 a 2)) crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(esPrimo 12) --> FALSE" crlf)
	(printout t (esPrimo 12) crlf)
	(printout t "(esPrimo 293)--> TRUE" crlf)
	(printout t (esPrimo 293) crlf)
	(printout t "(esPrimo -12)--> FALSE" crlf)
	(printout t (esPrimo -12) crlf)
	(printout t "(esPrimo 12a)--> El parametro debe ser un numero" crlf)
	(printout t (esPrimo 12a) crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(esCapicua 12) --> FALSE" crlf)
	(printout t (esCapicua 12) crlf)
	(printout t "(esCapicua 292)--> TRUE" crlf)
	(printout t (esCapicua 292) crlf)
	(printout t "(esCapicua -121)--> TRUE" crlf)
	(printout t (esCapicua -121) crlf)
	(printout t "(esCapicua 12a)--> El parametro debe ser un numero" crlf)
	(printout t (esCapicua 12a) crlf)
	(printout t "--------------------------" crlf)
	(printout t "--------------------------" crlf)
	(printout t "(num_magico) β 290919 β 30 β 3" crlf)
	(printout t (num_magico) crlf)
	(printout t "(num_magico) β 555555 β 30 β 3" crlf)
	(printout t (num_magico) crlf)
	(printout t "(num_magico) β a Debe ser un numero" crlf)
	(printout t (num_magico) crlf)
	(printout t "(num_magico) β -999999 -> 9" crlf)
	(printout t (num_magico) crlf)
		
)
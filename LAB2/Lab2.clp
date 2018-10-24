(defglobal ?*var1* = -1) 

(deffunction cuentaAtras (?a)
	(if (integerp ?a)
		then
		(if (< ?a 0) 
			then 
			(return "El valor tiene que ser un numero positivo")
		else
			(switch ?a
				(case 1 then
					(printout t "1" crlf)
				)
				(default 
					(printout t ?a " ")
					(cuentaAtras (- ?a 1))
				)
			)
		)
	else
		(return "El valor tiene que ser un numero positivo")
	)
)

(deffunction hasta (?a)
	(bind ?acum 0)
	(if (integerp ?a)
		then
		(if (< ?a 0) 
			then 
			(return "El valor tiene que ser un numero positivo")
		else
			(loop-for-count ?a
					(printout t ?acum " ")
					(bind ?acum (+ ?acum 1))
			)
			(return ?a)
		)
	
	else
		(return "El valor tiene que ser un numero positivo")
	)
)


(deffunction minimoMulti ($?var)
	(bind ?min (nth$ 1 $?var))
	(progn$ (?field $?var)
		(if(not(integerp ?field))
		then (printout t "El parametro debe ser un número" crlf)
		     (return FALSE)
		else
			(if (> ?min ?field)
				then (bind ?min ?field)
			)
		)
	)
	(return ?min)
	
)

((deffunction maximoMulti ($?var)
	(bind ?max (nth$ 1 $?var))
	(progn$ (?field $?var)
		(if(not(integerp ?field))
		then (printout t "El parametro debe ser un número" crlf)
		     (return FALSE)
		else
			(if (< ?max ?field)
				then (bind ?max ?field)
			)
		)
	)
	(return ?max)
	
)


(deffunction sumaMulti ($?var)
	(bind ?result 0)
	(bind ?acum 0)
	(progn$ (?field $?var)
		(if(not(integerp ?field))
		then (printout t "El parametro debe ser un número" crlf)
		     (return FALSE)
		else(bind ?result (+ ?acum ?field))
		    (bind ?acum ?result)
		)
	)
	(return ?result)
)
	
(deffunction mediaMulti ($?var)
	(bind ?result 0)
	(bind ?acum 0)
	(bind ?cuantas (length $?var))
	(progn$ (?field $?var)
		(if(not(integerp ?field))
		then (printout t "El parametro debe ser un número" crlf)
 		     (return FALSE)
		else(bind ?result (+ ?acum ?field))
		    (bind ?acum ?result)
		)
	)
	(bind ?result (/ ?acum ?cuantas))
	(return ?result)
)

(deffunction switching (?a $?b)
		(if (= ?a 1)
			then
			(printout t (maximoMulti $?b) crlf)
		else (if (= ?a 2)
			  then
			  (printout t (minimoMulti $?b) crlf)
			  else (printout t "numero introducido no valido" crlf)
			  )
		)
)

(deffunction multiplicarElemento (?a $?b) 
	(bind ?i 1)
	(progn$ (?var $?b)
		(if (integerp ?var)
		then 
			 (bind $?b (replace$ $?b ?i ?i (* ?var ?a)))
			 (bind ?i (+ ?i 1))
		else
			(return "No todos los valores son numeros")
		)
	)
	(return $?b)
)

(deffunction sumatorioNormal (?a)
	(bind ?suma 0)
	(bind ?contador 1)
	(bind ?acum 1)
	(bind ?acum2 1)
	(if(not(integerp ?a))
	 then (printout t "El parametro debe ser un número" crlf)
		(return FALSE)
	else
		(printout t "Empieza el sumatorio" crlf)
		(printout t "1 + ")
		(while (< ?contador (- ?a 1))
			(bind ?suma (+ 1 ?contador))
			(bind ?acum (+ ?suma ?acum2))
			(bind ?acum2 ?acum)
			(printout t ?suma " + ")
			(bind ?contador ?suma)
		)
		(bind ?acum (+ ?a ?acum2))
		(printout t ?a "= ")
	)

	(return ?acum)

)

		

(deffunction sumatorioRecursivo (?a)
	(bind ?suma 0)
	(if(not(integerp ?a))
	 then (printout t "El parametro debe ser un número" crlf)
		(return FALSE)
	else
		(if(= ?*var1* -1)
		then (bind ?*var1* ?a)
		)
		(switch ?a
			(case 1 then
				(printout t "1 = " )
				(return 1)
			)
			(case ?*var1* then
				(printout t ?*var1* " + ")
				(return  (+ (sumatorioRecursivo(- ?a 1)) ?a))
			)

			(default (printout t ?a " + ")
				 (return  (+ (sumatorioRecursivo(- ?a 1)) ?a))
			)
		)
	)
)
	
(deffunction sumatorio (?a)
	(bind ?*var1* ?a)
	(bind ?escribe 0)	
	 (printout t " Deseas Normal (N) o Recursivo (R)" crlf)
	(bind ?respuesta (read)) 
	(while (= ?escribe 0)
		(if(not(lexemep ?respuesta ))
		then 	 (printout t " Error debe ser una letra" crlf)
			 (printout t " Introduzca R si desea Recursivo" crlf)
			 (printout t " Introduzca N si desea Normal" crlf)
			 (bind ?respuesta (read))
		else(switch ?respuesta 
	 		(case N then
				(bind ?escribe 1)
				 (return (sumatorioNormal ?a))
			)
			(case R then	
				(bind ?escribe 1)
				(return (sumatorioRecursivo ?a))
			)
			(default (printout t " Introduzca R si desea Recursivo" crlf)
				 (printout t " Introduzca N si desea Normal" crlf)
				 (bind ?respuesta (read)) 
			)
		   )
		)
	)

)


(deffunction factorialNormal (?a)
	(bind ?b 1)
	(bind ?c 1)
	(if(not(integerp ?a))
	 then (printout t "El parametro debe ser un número" crlf)
		(return FALSE)
	else	
		(loop-for-count ?a
			(bind ?c (* ?b ?c))
			(bind ?b (+ ?b 1))
		)
	)
	(return ?c)
)		

(deffunction factorialRecursivo (?a)
	(if (integerp ?a)
		then
		(if (< ?a 0) 
			then 
			(return "El valor tiene que ser un numero positivo")
		else
			(switch ?a
				(case 0 then
					(return 0))
				(case 1 then
					(return 1))
				(default
					(return (* ?a (factorialRecursivo (- ?a 1)))))))
	else
		(return "El valor tiene que ser un numero positivo")
	)
 )


(deffunction factorial(?a)
	(bind ?escribe 0)	
	 (printout t " Deseas Normal (N) o Recursivo (R)" crlf)
	(bind ?respuesta (read)) 
	(while (= ?escribe 0)
		(if(not(lexemep ?respuesta ))
		  then 	 (printout t " Error debe ser una letra" crlf)
			 (printout t " Introduzca R si desea Recursivo" crlf)
			 (printout t " Introduzca N si desea Normal" crlf)
			 (bind ?respuesta (read))
		else(switch ?respuesta 
	 		(case N then
				(bind ?escribe 1)
				 (return (factorialNormal ?a))
			)
			(case R then	
				(bind ?escribe 1)
				(return (factorialRecursivo ?a))
			)
			(default (printout t " Introduzca R si desea Recursivo" crlf)
				 (printout t " Introduzca N si desea Normal" crlf)
				 (bind ?respuesta (read)) 
			)
		   )
		)
	)

)



 
(deffunction fib (?a)
	(if (integerp ?a)
		then
		(if (< ?a 0) 
			then 
			(return "El valor tiene que ser un numero positivo")
		else
			(switch ?a
				(case 0 then
					(return 0)
				)
				(case 1 then
					(return 1)
				)
				(default
					(return (+ (fib (- ?a 1)) (fib (- ?a 2))))
				)
			)
		)
	else
		(return "El valor tiene que ser un numero positivo")
	)
)


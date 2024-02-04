segm_stiva SEGMENT		 
    stiva DW 128 DUP (?) ;se defineste o zona de 128 de cuvinte pt stiva
segm_stiva ENDS			 

segm_date SEGMENT	 	 
    minn DW ?			 ;minn stocheaza minimul din vector
    rez DW ?			 ;rez stocheaza suma dintre factorial si minim
    fact DW 1			 ;fact stocheaza rezult factorialului, initializata cu 1
    vector DW 5 DUP (6, 9, 7, 5, 8)    ;vector de 5 elemente
segm_date ENDS		

segm_cod SEGMENT		
    ASSUME CS:segm_cod, DS:segm_date, SS:segm_stiva 	;directiva care face
;asignarile dintre registrii de segment si segmentele corespunzatoare


start:					    ;punctul de pornire al programului
    MOV AX, segm_date		;se încarca adresa segmentului de date în AX
    MOV DS, AX				;se seteaza segmentul de date cu adresa incarcata în AX

			;Calculul factorialului unui numar, ex: 5!
    MOV CX, 5			 ;initializam CX cu 5
    MOV AX, 1			 ;initializam AX cu 1 pt calculul factorialului
iar:
    MUL CX				 ;se multiplica AX cu CX
    LOOP iar		 	 ;se repeta pana cand CX devine 0
    MOV fact, AX		 ;rezultatul factorialului este stocat în fact

			
			;Gasirea minimului în vector
    MOV SI, OFFSET vector		  ;mutam adresa inceputului vectorului în SI
    MOV CX, LENGTH vector-1 	  ;initializam CX cu lungimea vectorului  -1
    MOV AX, [SI]				  ;mutam prima valoare din vector în AX
reia:
    CMP [SI], AX				  ;comparam valoarea curenta cu minimul
    JGE nu_min				 	  ;daca valoarea curenta nu este mai mica, se sare la nu_min
    MOV AX, [SI]				  ;actualiza minimul cu valoarea curenta
nu_min:
    ADD SI, TYPE vector			  ;se trece la urmatorul element din vector
    LOOP reia					  ;se repeta pana cand s-a parcurs tot vectorul
    MOV minn, AX				  ;valoarea minima finala este stocata in minn
	
			
			;Calculul sumei dintre factorial și minim
    MOV AX, fact		  ;mutam factorialul în AX
    ADD AX, minn		  ;adunam minimul la factorial
    MOV rez, AX			  ;rezultatul este stocat in rez

			
			;Terminarea programului
    MOV AX, 4C00H		  ;se seteaza AX cu 4C00H pt a indica sfarsitul programului
    INT 21H				  ;se realizeaza o intrerupere pt a reveni la sistemul de operare

segm_cod ENDS			  ;se încheie segmentul de cod
END start				 
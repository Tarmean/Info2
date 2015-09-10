#include <stdio.h>  // standard input output
#include <stdlib.h> // standard library

/*
 * Inline Assembler: Summiere die Zahlen von 1 bis n
 */
int inlineSum(int n);


/*
 * Main Methode
 */
int main (int argc, char** argv){

	int input;

	// Einige sanity checks fuer das uebergebene Argument
	int valid=1;
	if(argc != 2) valid = 0;
	else {

    input = atoi(argv[1]);
		 if(input < 1 ) valid = 0;
	 }
	if(valid == 0){
		printf("Invalid input: the first and only argument should be an integer greater than 0\n");
		return -1;
	}

	// rufe inlineSum
	int ret = inlineSum(input);

	// Ausgabe der Berechnung
	printf("%i\n",ret);

	// Erfolgreiche Terminierung
	return 0;
}

/*
 * Berechnung der Summe der Zahlen 1 bis n
 * unter Verwendung von Inline-Assembler.
 *
 * @params n: Letztes Glied der Summe
 * @return int Summe der Zahlen 1 bis n
 */
int inlineSum(int n){
	int ret = 0;
	__asm__ (
           //I could escape the new line but I think C concats strings that come after another?
           "loop:;"              //loop head
           "add %%eax, %%ecx;"   //a+=n
           "dec %%eax;"			     //n--
           "jnb loop;"           //does jnb become the same as jle?
	: "=c" (ret)			/* Ausgabe: Schreibe ecx Register
							   in ret (C-Variable) */
	: "a" (n) 				/* Eingabe: Schreibe n (C-Variable)
							   ins eax Register */
	:						/* clobbered registers: Angabe von
							   Registern, die modifiziert wurden */
              //of which there are none
	);
    return ret;
}

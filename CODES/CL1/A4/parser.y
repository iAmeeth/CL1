%{
#include "y.tab.h"
#include<stdio.h>
extern FILE *yyin;
%}

%token MAIN PRINTF IF ELSE WHILE RETURN DATATYPE FOR INTEGER FLOAT IDENTIFIER LOGOP OP STCONST

%%

main: MAIN '('')' '{' body '}' {printf("Main encountered\n");}
;
body: varstmt stmtlist
;
varstmt:varlist varstmt |
;
varlist:DATATYPE variable ';'{printf("Valid declaration\n");}
;
variable: IDENTIFIER ',' variable | IDENTIFIER 
;
stmtlist:stmt stmtlist |
;
stmt: printf
printf: PRINTF '(' STCONST ')'';' {printf("Valid Print Statement\n");}
;


%%

main()
{
	yyin=fopen("input.txt","r");
	yyparse();
}

void yyerror(char *s)
{
	printf("\nInvalid character..%s",s);
}

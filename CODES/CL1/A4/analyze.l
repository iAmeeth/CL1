%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
extern int yylval;
%}

digit       [0-9]
ichar       [A-Z_a-z]
integer     {digit}+
identifier  {ichar}([0-9]|{ichar})*
float       ([+-]?{digit}+)?\.{digit}*(e?[+-]?{digit}+)?
%%
[ \t\n]+ ;
main				{return MAIN;}
printf				{return PRINTF;}
if            			{return IF;}
else          			{return ELSE;}
while         			{return WHILE;}
return        			{return RETURN;}
int|float|char|double|string	{return DATATYPE;}
for				{return FOR;}
\"[ a-zA-Z0-9]+\"               {return STCONST;}
"="  |             
"!=" |           
"==" |          
"<"  |         
"<=" |          
">"  |          
">=" |         
"&&" |          
"||" 				{return LOGOP;}           

"+"  |           
"-"  |           
"*"  |           
"/"           			{return OP;}           

"{"  |           
"}"  |           
"["  |          
"]"  |           
"("  |          
")"  |           
";"  |           
","             {return yytext[0];}

{integer}	{yylval=atoi(yytext);return INTEGER;}
{float}		{yylval=atof(yytext);return FLOAT;}
{identifier}	{return IDENTIFIER;}


.               {return yytext[0];}

%%
int yywrap()
{
return 1;
}

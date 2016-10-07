%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>

%}

%%
[ \t\n]+   ;
int|float|char|double   {strcpy(yylval.str,yytext); return DTYPE;}
if                      {return IF;}
else                    {return ELSE;}
while                   {return WHILE;}
[0-9]+     {yylval.ival=atoi(yytext); return NUM;}
";"|"="|","|"("|")"|"{"|"}"        {return yytext[0];}
"+"|"-"|"*"|"/"    {return yytext[0];}
">"|"<"|">="|"<="|"=="  {strcpy(yylval.str,yytext); return RLOP;}
[a-zA-Z][a-zA-Z0-9]* {strcpy(yylval.str,yytext); return VAR;}

%%


int yywrap()
{return 1;}

%{
#include <stdio.h>
#include <string.h>
int lno=1;
FILE* opfile;
char name[20][20];
int cnt=0;

int elno[20];
char edesc[20][100];
int ecnt=0;
%}

%%

[0-9]+   {printf("%d   %s                 NUMBER\n",lno,yytext); fprintf(opfile,"%s ",yytext);}
[-+*/]   {printf("%d   %s                 OPERATOR\n",lno,yytext); fprintf(opfile,"%s ",yytext);}
=        {printf("%d   %s                 ASSIGNMENT\n",lno,yytext); fprintf(opfile,"%s ",yytext);}
include|main|return   {printf("%d   %s              KEYWORD\n",lno,yytext); fprintf(opfile,"%s ",yytext);}
int|float|char|double   {printf("%d   %s               DATATYPE\n",lno,yytext); fprintf(opfile,"%s ",yytext);}

[\t ]      ;
\n      {lno++; fprintf(opfile,"\n");}
(\/\/.*)       ;
(\/\*[^*/]*\*\/) ;
(\/\*[^*/]*)     {elno[ecnt]=lno;  char str[100]="Unterminated comment  ";strcat(str,yytext); strcpy(edesc[ecnt],str);ecnt++;}
#       {printf("%d   %s               PREPROCESSOR\n",lno,yytext); fprintf(opfile,"%s ",yytext);}
;       {printf("%d   %s               TERMINATOR\n",lno,yytext); fprintf(opfile,"%s ",yytext);}
\<       {printf("%d   %s              LESS THAN\n",lno,yytext); fprintf(opfile,"%s ",yytext);}
\>       {printf("%d   %s              GREATER THAN\n",lno,yytext); fprintf(opfile,"%s ",yytext);}
\{       {printf("%d   %s              START OF BLOCK\n",lno,yytext);fprintf(opfile,"%s ",yytext);}
\}       {printf("%d   %s              END OF BLOCK\n",lno,yytext);fprintf(opfile,"%s ",yytext);}
\(       {printf("%d   %s              OPEN\n",lno,yytext);fprintf(opfile,"%s ",yytext);}
\)       {printf("%d   %s              CLOSE\n",lno,yytext);fprintf(opfile,"%s ",yytext);}
\[       {printf("%d   %s              OPEN\n",lno,yytext);fprintf(opfile,"%s ",yytext);}
\]       {printf("%d   %s              CLOSE\n",lno,yytext);fprintf(opfile,"%s ",yytext);}
,        {printf("%d   %s              SEPARATOR\n",lno,yytext);fprintf(opfile,"%s ",yytext);}
printf|scanf   {printf("%d   %s             LIBRARY FUNCTION\n",lno,yytext);fprintf(opfile,"%s ",yytext);}
(\"[^\"]*\")   {printf("%d   %s              STRING CONSTANT\n",lno,yytext);fprintf(opfile,"%s ",yytext);}
(\"[^\"\n]*\n)     {elno[ecnt]=lno;   char str[100]="Unterminated quotes ";strcat(str,yytext); strcpy(edesc[ecnt],str); ecnt++; lno++;}
([a-zA-Z0-9]+\.h) {printf("%d   %s                HEADER FILE\n",lno,yytext);fprintf(opfile,"%s ",yytext);}
[a-zA-Z][a-zA-Z0-9]* {printf("%d   %s                  IDENTIFIER\n",lno,yytext);fprintf(opfile,"%s ",yytext); 
st_add(yytext);}

[0-9]+[a-zA-Z]+ {elno[ecnt]=lno;   char str[100]="Unrecognized token ";strcat(str,yytext); strcpy(edesc[ecnt],str); ecnt++; }

[a-zA-Z][a-zA-Z0-9]*[\?@$][a-zA-Z0-9]* {elno[ecnt]=lno;   char str[100]="Unrecognized token ";strcat(str,yytext); strcpy(edesc[ecnt],str); ecnt++; }
%%
void st_add(char s[20])
{
int i;
 for(i=0;i<cnt;i++)
  {if(strcmp(name[i],s)==0) return;}
 strcpy(name[cnt],s);
 cnt++;
}
main()
{
char ifile[100],ofile[100];
printf("\nEnter input file name:     ");
scanf("%s",ifile);
yyin=fopen(ifile,"r");


printf("\nEnter output file name:     ");
scanf("%s",ofile);
opfile=fopen(ofile,"w");


int i;
printf("Line No     LEXEME                       Token\n");
yylex();

printf("\nSymbol Table\n");

for(i=0;i<cnt;i++)
{printf("\n %s  ",name[i]);
}

printf("\nLexical Errors:  Found  %d\n",ecnt);
for(i=0;i<ecnt;i++)
{printf("\nLine no.  %2d  \t   %s",elno[i],edesc[i]);}
return 0;
}

int yywrap()
{
return 1;
}

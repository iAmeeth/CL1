%{
#include <stdio.h>
#include <string.h>
extern FILE* yyin;

static int temp_no=1;

struct SymTab
{
char name[20];
char type[10];
int value;
};

struct Quadr
{
char opn[10];
char op1[20];
char op2[20];
char res[20];
};

struct SymTab sym[30];
int cnt=0;

struct Quadr qtab[40];
int qcnt=0;

char stack[50][20];
int stop=-1;

int ifpos=-1;
%}

%token <ival> NUM
%token <str> VAR
%token <str> DTYPE
%token <str> OP
%token IF
%token ELSE
%token WHILE
%token <str>RLOP

%left '+' '-'
%left '*' '/'

%union
{

int ival;
char str[20];
}

%%
S: stmt S|stmt {printf("\nCorrect Syntax!!!");
                };

stmt: decl|expr|assign|vassg|ifst|ifel|wst;
decl: DTYPE varlist ';' ;

varlist: VAR {add($1,$<str>0,0);}|
         VAR '=' NUM {add($1,$<str>0,$3);} {}|
         varlist ',' VAR {add($3,$<str>0,0);}|
         varlist ',' VAR '=' NUM {add($3,$<str>0,$5);};

vassg:  VAR '=' expr ';' 
        {   char op1[30];
            strcpy(op1,pop());
            if(strcmp(ret_type(op1),ret_type($1))!=0)
            {  char str[5];
               strcpy(str,temp_name());
              addQuadr(ret_type($1),op1,"",str);
              addQuadr("=",str,"",$1);
            }
            else{  addQuadr("=",op1,"",$1);  }
         };

wst:  wp1 wp2;
wp1: WHILE '(' rlop ')' '{'  { addQuadr("if",pop(),"","goto L1");
                              addQuadr("else:","","","goto L2:");
                              addQuadr("L1:","","","");};

wp2:  S '}'                  {addQuadr("goto L1","","","");
                               addQuadr("L2:","","","");};

ifst: if1 if2 ;
if1: IF '(' rlop ')'   {addQuadr("if",pop(),"","goto L1");
                        addQuadr("L1:","","","");};
if2: '{' S '}'        {addQuadr("L2:","","","");};

ifel:  if1 if5 if2 ;

if5: '{' S '}' ELSE       { addQuadr("goto L2:","","","");
                        addQuadr("else:","","","");
                        addQuadr("L3:","","","");};




rlop:   VAR RLOP VAR   
        {
              char str[5];
              strcpy(str,temp_name());
              addQuadr($2,$1,$3,str);
              push(str);  
         };


expr:   expr '+' expr
        {
           char op1[30],op2[30];
           strcpy(op1,pop());
           strcpy(op2,pop());
           printf("Type:   %s     %s",ret_type(op1),ret_type(op2));
           
           

           if(strcmp(ret_type(op1),ret_type(op2))!=0) 
           {  if(prec(ret_type(op2))>prec(ret_type(op1))) 
              {     
                    char str1[5];
                    strcpy(str1,temp_name());
                    addQuadr(ret_type(op2),op1,"",str1);
                    char str[5];
                    strcpy(str,temp_name());
                    addQuadr("+",op2,str1,str);
                    push(str);
                    add(str,ret_type(op2),0);
              }

              else if(prec(ret_type(op2))<prec(ret_type(op1))) 
               {  
                    char str1[5];
                    strcpy(str1,temp_name());
                    addQuadr(ret_type(op1),op2,"",str1);
                    char str[5];
           strcpy(str,temp_name());
                    addQuadr("+",op1,str1,str);
                    push(str);
                    add(str,ret_type(op1),0);
               }
           else{
           char str[5];
           strcpy(str,temp_name());
            addQuadr("+",op1,op2,str); 
           push(str);
           
           }
           
        }}|
        expr '-' expr
        {
           char op1[30],op2[30];
           strcpy(op1,pop());
           strcpy(op2,pop());
           printf("Type:   %s     %s",ret_type(op1),ret_type(op2));
           
           

           if(strcmp(ret_type(op1),ret_type(op2))!=0) 
           {  if(prec(ret_type(op2))>prec(ret_type(op1))) 
              {     
                    char str1[5];
                    strcpy(str1,temp_name());
                    addQuadr(ret_type(op2),op1,"",str1);
                    char str[5];
                    strcpy(str,temp_name());
                    addQuadr("-",op2,str1,str);
                    push(str);
                    add(str,ret_type(op2),0);
              }

              else if(prec(ret_type(op2))<prec(ret_type(op1))) 
               {  
                    char str1[5];
                    strcpy(str1,temp_name());
                    addQuadr(ret_type(op1),op2,"",str1);
                    char str[5];
           strcpy(str,temp_name());
                    addQuadr("-",op1,str1,str);
                    push(str);
                    add(str,ret_type(op1),0);
               }
           else{
           char str[5];
           strcpy(str,temp_name());
            addQuadr("-",op1,op2,str); 
           push(str);
           
           }
           
        }
        }|
	expr '*' expr
        {
          char op1[30],op2[30];
           strcpy(op1,pop());
           strcpy(op2,pop());
           printf("Type:   %s     %s",ret_type(op1),ret_type(op2));
           
           

           if(strcmp(ret_type(op1),ret_type(op2))!=0) 
           {  if(prec(ret_type(op2))>prec(ret_type(op1))) 
              {     
                    char str1[5];
                    strcpy(str1,temp_name());
                    addQuadr(ret_type(op2),op1,"",str1);
                    char str[5];
                    strcpy(str,temp_name());
                    addQuadr("*",op2,str1,str);
                    push(str);
                    add(str,ret_type(op2),0);
              }

              else if(prec(ret_type(op2))<prec(ret_type(op1))) 
               {  
                    char str1[5];
                    strcpy(str1,temp_name());
                    addQuadr(ret_type(op1),op2,"",str1);
                    char str[5];
           strcpy(str,temp_name());
                    addQuadr("*",op1,str1,str);
                    push(str);
                    add(str,ret_type(op1),0);
               }
           else{
           char str[5];
           strcpy(str,temp_name());
            addQuadr("*",op1,op2,str); 
           push(str);
           
           }
           
        } 
        }|
	expr '/' expr
        {
           char op1[30],op2[30];
           strcpy(op1,pop());
           strcpy(op2,pop());
           printf("Type:   %s     %s",ret_type(op1),ret_type(op2));
           
           

           if(strcmp(ret_type(op1),ret_type(op2))!=0) 
           {  if(prec(ret_type(op2))>prec(ret_type(op1))) 
              {     
                    char str1[5];
                    strcpy(str1,temp_name());
                    addQuadr(ret_type(op2),op1,"",str1);
                    char str[5];
                    strcpy(str,temp_name());
                    addQuadr("/",op2,str1,str);
                    push(str);
                    add(str,ret_type(op2),0);
              }

              else if(prec(ret_type(op2))<prec(ret_type(op1))) 
               {  
                    char str1[5];
                    strcpy(str1,temp_name());
                    addQuadr(ret_type(op1),op2,"",str1);
                    char str[5];
           strcpy(str,temp_name());
                    addQuadr("/",op1,str1,str);
                    push(str);
                    add(str,ret_type(op1),0);
               }
           else{
           char str[5];
           strcpy(str,temp_name());
            addQuadr("/",op1,op2,str); 
           push(str);
           
           }
           
        }
        }|
        VAR   
       {
          if(search($1)==-1)
            {printf("\nUndefined Variable %s",$1);}
          else
            push($1);   
        };



assign: VAR '=' NUM ';'
        {   printf("\nAssignment");
             strcpy(qtab[qcnt].opn,"=");
            sprintf(qtab[qcnt].op1, "%d", $3);
            strcpy(qtab[qcnt].res,$1);
            qcnt++;
        }
;


%%
void addQuadr(char* op,char* o1, char* o2, char* r)
{
               strcpy(qtab[qcnt].opn,op);
               strcpy(qtab[qcnt].op1,o1);
               strcpy(qtab[qcnt].op2,o2);
               strcpy(qtab[qcnt].res,r);
               qcnt++;

}

void push(char* str)
{
strcpy(stack[++stop],str);
}

char* pop()
{
return stack[stop--];
}

char* temp_name()
{
char str[5];
strcpy(str,"t");
char str1[5];
sprintf(str1,"%d",temp_no);
temp_no++;
strcat(str,str1);
printf("%s",str);
return str;
}
int prec(char type[10])
{
if(strcmp(type,"char")==0)  return 0;
else if(strcmp(type,"int")==0)  return 1;
else if(strcmp(type,"float")==0)  return 2;
else if(strcmp(type,"double")==0)  return 3;
}

int search(char name[20])
{
if(cnt==0) {return -1;}
else
{
int i;
for(i=0;i<cnt;i++)
{if(strcmp(name,sym[i].name)==0)  return 0;}
}
return -1;
}

void add(char name[20],char type[10],int val)
{
if(search(name)==0)  {printf("\nRedeclaration of variable  %s\n",name); return;}
strcpy(sym[cnt].name,name);
strcpy(sym[cnt].type,type);
sym[cnt].value=val;
cnt++;
}

void disp()
{
int i;
for(i=0;i<cnt;i++)
{
printf("\n Name:  %s    Type:  %s    Value:   %d",sym[i].name,sym[i].type,sym[i].value);
}
}

char* ret_type(char name[20])
{
if(cnt==0) {return NULL;}
else
{
int i;
for(i=0;i<cnt;i++)
{if(strcmp(name,sym[i].name)==0)  return sym[i].type;}
}
return NULL;
}
void yyerror(char* s)
{
printf("Incorrect Syntax at  %s",s);
}


int main()
{
char ifile[100];
printf("\nEnter input file name:     ");
scanf("%s",ifile);
yyin=fopen(ifile,"r");

yyparse();
printf("\nSymbol Table:\n");
disp();
int i;
printf("\nQuadruple:\n");
for(i=0;i<qcnt;i++)
{
printf("\n%s\t%s\t%s\t%s",qtab[i].opn,qtab[i].op1,qtab[i].op2,qtab[i].res);
}
}

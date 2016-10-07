%{ 
#include<stdio.h>
#include<string.h>
#include<malloc.h>

int line_no=1;
int gl_index=0;



struct symbol_table{
char name[20];
int index;
struct symbol_table *next;
};

struct symbol_table *head=NULL;

int look_up(char lexeme[20])
{
	printf("in start of lookup\n");
	struct symbol_table *temp;
	temp=head;
	
	while(temp!=NULL)
	{
		printf("%s%shi\n",lexeme,temp->name);
		if(strcmp(lexeme,temp->name)==0)
		{
			printf("Equal\n");
			return 10;
		}
	temp=temp->next;
	}
	printf("in lookup\n");	
	return 1000;
}


void insert_into(char lexeme[20])
{
	if(look_up(lexeme)!=1000)
	{
		return;
	}
	printf("....");
	struct symbol_table *temp;
	strcpy(temp->name,lexeme);
	temp->index=gl_index;
	++gl_index;
	if(head==NULL)
	{
		head=temp;
		head->next=NULL;
		printf("head node created\n");
	}
	else
	{
		struct symbol_table *t;
		t=(struct symbol_table *)head;
		while(t->next!=NULL)
		{
			t=t->next;
		}
		t->next=temp;
		t=temp;
		t->next=NULL;
	
		printf("in here\n");
	}
printf("in end of insert");
}

void display()
{
	printf("TOKEN \t\t INDEX\n");
	printf("hi");
	struct symbol_table *temp1;
	
	temp1=head;
	
	while(temp1!=NULL)
	{
		printf("inside while");
		temp1=temp1->next;
	}
}



	
%}

comment		\/\*([^*]|\n)*\*\/
digit 		[0-9]
letter		[a-zA-Z]
integer		{digit}+
newline		\n
identifier	{letter}([0-9]|{letter})*
whitespace	[ \t]+
header		#include<.*>
main		main()


%%
"if"		{fprintf(yyout,"if ");printf("%d \t\t IF \t\t IF\n",line_no);}
"while" 	{fprintf(yyout,"while ");printf("%d \t\t WHILE \t\t WHILE\n",line_no);}
"else"  	{fprintf(yyout,"else ");printf("%d \t\t ELSE \t\t ELSE\n",line_no);}
"for"   	{fprintf(yyout,"for ");printf("%d \t\t FOR \t\t FOR\n",line_no);}
"continue" 	{fprintf(yyout,"continue ");printf("%d \t\t CONTINUE \t\t CONTINUE\n",line_no);}
"break" 	{fprintf(yyout,"break ");printf("%d \t\t BREAK \t\t BREAK\n",line_no);}
"switch"	{fprintf(yyout,"switch ");printf("%d \t\t SWITCH \t\t SWITCH\n",line_no);}
"int "		{fprintf(yyout,"int ");printf("%d \t\t INT \t\t DATATYPE\n",line_no);}
"char "		{fprintf(yyout,"char ");printf("%d \t\t CHAR \t\t DATATYPE\n",line_no);}

"="  |             
"!=" |          
"==" |          
"<"  |           
"<=" |          
">"  |           
">=" |           
"&&" |          
"||"            {fprintf(yyout,yytext);fprintf(yyout," ");printf("%d \t\t %s \t\t OPERATOR\n",line_no,yytext);}

"+"  |         
"-"  |         
"*"  |           
"/"  |           
"%"            {fprintf(yyout,yytext);fprintf(yyout," ");printf("%d \t\t %s \t\t OPERATOR\n",line_no,yytext);}

"{"  |          
"}"  |           
"["  |           
"]"  |          
"("  |           
")"            {fprintf(yyout,yytext);fprintf(yyout," ");printf("%d \t\t %s \t\t SYMBOL\n",line_no,yytext);}
";"             {fprintf(yyout,";\n");printf("%d \t\t ; \t\t TERMINATOR\n",line_no);}
","             {fprintf(yyout,", ");printf("%d \t\t , \t\t SEPARATOR\n",line_no);}

{comment}|{whitespace}	;
{header}	{fprintf(yyout,yytext);fprintf(yyout,"\n");printf("%d \t\t %s HEADER\n",line_no,yytext);}
{integer} 	{fprintf(yyout,yytext);fprintf(yyout," ");printf("%d \t\t %s \t\t CONSTANT\n",line_no,yytext);}
main		{fprintf(yyout,yytext);fprintf(yyout,"\n");printf("%d \t\t %s \t\t MAIN\n",line_no,yytext);}
{identifier}	{fprintf(yyout,yytext);fprintf(yyout," ");printf("%d \t\t %s \t\t IDENTIFIER\n",line_no,yytext); insert_into(yytext);}
		

{newline}	{line_no=line_no+1;}

%%


main()
{
	FILE *fp,*fout;
	printf("===================================================\n");
	printf("LINE_NO \t LEXEME \t TOKEN\n");
	printf("===================================================\n");
	fp=fopen("input.txt","r");
	fout=fopen("output.txt","w");
	yyout=fout;
	yyin=fp;
	
	yylex();
	display();
}

int yywrap()
{
	
	return 1;
}

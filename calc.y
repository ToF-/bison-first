/* infix notation calculator */

%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void);
    void yyerror(char const *);
%}

%define api.value.type { double }
%token NUM
%left '-' '+'
%left '*' '/'
%precedence NEG 
%right '^'

%%

input:
    '\n'
  | exp '\n'            { printf("\t%.10g\n", $1); }
  | error '\n'          { printf("there is an error\n"); exit(0); }
  ;

exp:
    NUM
  | exp '+' exp        { $$ = $1 + $2; }
  | exp '-' exp        { $$ = $1 - $2; }
  | exp '*' exp        { $$ = $1 * $2; }
  | exp '/' exp        { $$ = $1 / $2; }
  | '-' exp %prec NEG  { $$ = -$2; }
  | exp '^' exp        { $$ = pow($1, $3); }
  | '(' exp ')'        { $$ = $2; }
  ;
  
%%

#include <ctype.h>
#include <stdlib.h>

int yylex(void)
{
    int c = getchar();
    while (c == ' ' || c == '\t')
        c = getchar();
    if (c == '.' || isdigit(c))
    {
        ungetc(c, stdin);
        if (scanf("%lf", &yylval) !=1)
            abort();
        return NUM;
    }
    else if (c==EOF)
        return YYEOF;
    else
        return c;
}

int main()
{
    return yyparse();
}

#include <stdio.h>
void yyerror(char const *s)
{
    fprintf(stderr, "%s\n", "silly mistake");
}

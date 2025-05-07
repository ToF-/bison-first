/* loner problem */

%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void);
    void yyerror(char const *);
    static int line_count = 0;
    static int winnable;
%}

%token E
%token P
%token TEST_CASES
%token BOARD_SIZE

%%

input:
     TEST_CASES     { line_count++; printf("TEST_CASES\n"); }
     boards
     ;

boards:
    %empty
    | boards BOARD_SIZE { line_count++; winnable = 1; printf("BOARD_SIZE\n"); }
    board               { line_count++; }
    ;

board:
    win                                 { printf("yes\n"); }
  | lose                                { printf("no\n"); }
    
win:
   P
  | P P E
  | e_plus P P E
  | e_plus P P E e_plus
  | e_plus E P P e_plus
  ;

e_plus:
  %empty
  | E e_plus        { printf("0+\n"); }
  ;

lose:
  %empty
  | E lose
  | P lose
  ;

%%

#include <ctype.h>
#include <stdlib.h>

int yylex(void)
{
    int c = getchar();
    if (c==EOF)
    {
        printf("EOF\n");
        return YYEOF;
    }
    if(line_count == 0 || line_count % 2 == 1)
    {
        printf("line %d ignored\n", line_count);
        while(c != '\n')
            c = getchar();
        if(line_count == 0)
            return TEST_CASES;
        else
            return BOARD_SIZE;
    }
    else
    {
        if(c=='0')
            return E;
        if(c=='1')
            return P;
    }
    return c;
}

int main()
{
    return yyparse();
}

#include <stdio.h>
void yyerror(char const *s)
{
    fprintf(stderr, "%s\n", s);
}


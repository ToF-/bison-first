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
    | boards board
    ;

board:
    BOARD_SIZE                          { line_count++; winnable = 1; printf("BOARD_SIZE\n"); }
    e_star board_pattern e_star '\n'    { line_count++; printf("%s\n", winnable ? "yes" : "no"); }
    ;

e_star:
    %empty
  | e_star E
  ;

board_pattern:
    P
  | P P E
  | E P P
  | otherwise
  ;

otherwise:
  %empty
  | otherwise any                         { winnable = 0; printf("otherwise\n"); }
  ;

any:
    E
  | P
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


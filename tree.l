%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
%}

%%
[0-9]+ { yylval.ival = atoi(yytext); return NUMBER; }
[()\n] { return yytext[0]; }
Node { return NODE; }
count { return COUNT; }
insert { return INSERT; }
find { return FIND; }
delete { return DELETE; }
balanced { return BALANCED; }
Lf { return LF; }
[ \t] { /* ignore whitespace */ }
. { fprintf(stderr, "Error: Unknown character: %s\n", yytext); }

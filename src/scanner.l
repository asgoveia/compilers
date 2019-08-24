    //Scanner:
    //- Identifica Lexemas
    //- Classifica como Tokens

%{
#include "tokens.h"

int lineNumber = 1;

#include "hash.c"
%}

%x COMMENT

DIGIT [0-9]

%%

"int"                       {return KW_INT; }
"goto"
[A-Za-z_][A-Za-z_0-9]*      {return TK_IDENTIFIER; } 

{DIGIT}+                    {return LIT_INTEGER; }
{DIGIT}+"."{DIGIT}+         {return LIT_FLOAT; }

[-+*/()]                    {return yytext[0];}

"\n"                        {++lineNumber; return 5; }          
[ \n\t]                     {return 6; }
"\\".*                      {return 7; }

"/*"                        BEGIN(COMMENT);
<COMMENT>"*/"               BEGIN(INITIAL);
<COMMENT>"\n"               ++lineNumber;
<COMMENT>.                  

%%

int running = 1;

int yywrap(){
    running = 0;
    return 1;
}

#include "main.c"
%{
#include <stdio.h>   
void yyerror(const char* s) {
}
%}

%token tMAIL tENDMAIL tSCHEDULE tENDSCHEDULE tSEND tSET tTO tFROM tAT tCOMMA tCOLON tLPR tRPR tLBR tRBR tIDENT tSTRING tADDRESS tDATE tTIME
%%

program:    
        |   program set_statement
        |   program mail_block
        ;

mail_block: tMAIL tFROM tADDRESS tCOLON statement_list tENDMAIL
        |   tMAIL tFROM tADDRESS tCOLON tENDMAIL
        ;

statement_list: statement
        |       statement_list statement
        ;

statement:  set_statement
        |   send_statement
        |   schedule_statement
        ;

set_statement:  tSET tIDENT tLPR tSTRING tRPR
        ;

send_statement: tSEND tLBR tIDENT tRBR tTO recipient_list
        |       tSEND tLBR tSTRING tRBR tTO recipient_list
        ;

send_statement_list: send_statement
        |            send_statement_list send_statement
        ;

schedule_statement: tSCHEDULE tAT tLBR tDATE tCOMMA tTIME tRBR tCOLON send_statement_list tENDSCHEDULE
        ;

recipient:  tLPR tADDRESS tRPR
        |   tLPR tIDENT tCOMMA tADDRESS tRPR
        |   tLPR tSTRING tCOMMA tADDRESS tRPR
        ;

recipient_objects:  recipient
        |           recipient_objects tCOMMA recipient
        ;

recipient_list: tLBR recipient_objects tRBR
        ;


%%


int    main    ()
{
if    (yyparse())
{
//    parse    error
printf("ERROR\n");
return    1;
}
else
{
//    successful    parsing
printf("OK\n");
return    0;
}
}

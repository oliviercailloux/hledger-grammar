grammar Hledger;

COMMENT_BLOCK : 'comment' EOL .*? EOL 'end comment' EOL ;
COMMENT_LINE : '//' .*? EOL ;

EOL : '\r'? '\n' ;
SPACE : ' ' ;
SEP : SPACE SPACE+ ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
DATE : [0-9] [0-9] [0-9] [0-9] '-' [0-9] [0-9] '-' [0-9] [0-9] ;
SINGLE_SPACED_NON_KEYWORD : ~[ ;\r\n] (' '? ~[ ;\r\n])* ;


journal : (emptyLine | COMMENT_LINE | COMMENT_BLOCK | directive | transaction)* EOF ;

emptyLine : EOL ;

directive : (accountDirective | commodityDirective) ;

accountDirective : ACCOUNT SPACE accountName (SEP ';' commentText)? EOL ;
accountName : singleSpaced ;
singleSpaced : ACCOUNT | COMMODITY | DATE | SINGLE_SPACED_NON_KEYWORD ;
commentText : singleSpaced* ;

commodityDirective : COMMODITY SPACE commodityString (SEP ';' commentText)? EOL ;
commodityString : singleSpaced ;

transaction : DATE EOL ;

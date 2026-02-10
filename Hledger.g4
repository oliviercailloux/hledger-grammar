grammar Hledger;

COMMENT_BLOCK : 'comment' EOL .*? EOL 'end comment' EOL ;
COMMENT_LINE : '//' .*? EOL ;

EOL : '\r'? '\n' ;
SPACE : ' ' ;
ENDING_COMMENT : '  ' SPACE* ';' ~[\r\n]* EOL ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
DATE : [0-9] [0-9] [0-9] [0-9] '-' [0-9] [0-9] '-' [0-9] [0-9] ;
SINGLE_SPACED_NON_KEYWORD : ~[ ;\r\n] (SPACE? ~[ ;\r\n])* ;


journal : (emptyLine | COMMENT_LINE | COMMENT_BLOCK | directive | transaction)* EOF ;

emptyLine : EOL ;

directive : (accountDirective | commodityDirective) ;

accountDirective : ACCOUNT SPACE accountName ENDING_COMMENT? EOL ;
accountName : singleSpaced ;
singleSpaced : ACCOUNT | COMMODITY | DATE | SINGLE_SPACED_NON_KEYWORD ;
commentText : singleSpaced* ;

commodityDirective : COMMODITY SPACE commodityString ENDING_COMMENT? EOL ;
commodityString : singleSpaced ;

transaction : DATE EOL ;

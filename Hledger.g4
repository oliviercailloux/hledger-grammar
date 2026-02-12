grammar Hledger;

COMMENT_BLOCK : 'comment' EOL .*? EOL 'end comment' EOL -> channel(HIDDEN) ;
COMMENT_LINE : '//' .*? EOL -> channel(HIDDEN) ;

SEMICOLON : ';' ;
EQUALS : '=' ;
EOL : '\r'? '\n' ;
SPACE : ' ' ;
START_WITHIN_COMMENT : '  ;' ;
START_ASSERTION : '  =' ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
DATE : [0-9] [0-9] [0-9] [0-9] [-./] [01]? [0-9] [-./] [0-3]? [0-9] ;
OTHER_WORD : ~[ ;=\r\n]+ ;


journal : (emptyLine | directive | transaction)* EOF ;

emptyLine : EOL ;

directive : (accountDirective | commodityDirective | decimalDirective) ;

accountDirective : ACCOUNT SPACE+ accountName SPACE* endComment? EOL ;
accountName : multipleWords ;
multipleWords : word (SPACE word)* ;
word : ACCOUNT | COMMODITY | OTHER_WORD ;
endComment : START_WITHIN_COMMENT commentText ;
commentText : (SPACE | SEMICOLON | EQUALS | DATE | START_WITHIN_COMMENT | word)* ;

commodityDirective : COMMODITY SPACE+ commodityString SPACE* endComment? EOL ;
commodityString : multipleWords ;

decimalDirective : 

transaction : DATE SPACE* description SPACE* endComment? EOL posting* ;
description : (SPACE* (SEMICOLON | EQUALS | DATE | word))* ;
posting : SPACE+ accountName (SPACE SPACE+ commodityString)? SPACE* assertion? SPACE* endComment? EOL ;
assertion : START_ASSERTION SPACE* commodityString ;

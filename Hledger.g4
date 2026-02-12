grammar Hledger;

COMMENT_BLOCK : 'comment' EOL .*? EOL 'end comment' EOL -> channel(HIDDEN) ;
COMMENT_LINE : '//' .*? EOL -> channel(HIDDEN) ;

SEMICOLON : ';' ;
EOL : '\r'? '\n' ;
SPACE : ' ' ;
START_WITHIN_COMMENT : '  ;' ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
DATE : [0-9] [0-9] [0-9] [0-9] [-./] [01]? [0-9] [-./] [0-3]? [0-9] ;
OTHER_WORD : ~[ ;\r\n]+ ;


journal : (emptyLine | directive | transaction)* EOF ;

emptyLine : EOL ;

directive : (accountDirective | commodityDirective) ;

accountDirective : ACCOUNT SPACE+ accountName SPACE* endComment? EOL ;
accountName : multipleWords ;
multipleWords : word (SPACE word)* ;
word : ACCOUNT | COMMODITY | OTHER_WORD ;
endComment : START_WITHIN_COMMENT commentText ;
commentText : (SPACE | SEMICOLON | DATE | START_WITHIN_COMMENT | word)* ;

commodityDirective : COMMODITY SPACE+ commodityString SPACE* endComment? EOL ;
commodityString : multipleWords ;

transaction : DATE SPACE* commentText EOL (SPACE+ accountName SPACE SPACE+ commodityString SPACE* endComment? EOL)* ;

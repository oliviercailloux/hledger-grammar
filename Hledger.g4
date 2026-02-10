grammar Hledger;

COMMENT_BLOCK : 'comment' EOL .*? EOL 'end comment' EOL ;
COMMENT_LINE : '//' .*? EOL ;

SEMICOLON : ';' ;
EOL : '\r'? '\n' ;
SPACE : ' ' ;
START_WITHIN_COMMENT : '  ;' ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
DATE : [0-9] [0-9] [0-9] [0-9] [-./] [01]? [0-9] [-./] [0-3]? [0-9] ;
OTHER_WORD : ~[ ;\r\n]+ ;


journal : (emptyLine | COMMENT_LINE | COMMENT_BLOCK | directive | transaction)* EOF ;

emptyLine : EOL ;

directive : (accountDirective | commodityDirective) ;

accountDirective : ACCOUNT SPACE+ accountName (SPACE* START_WITHIN_COMMENT commentText)? EOL ;
accountName : multipleWords ;
multipleWords : word (SPACE word)* ;
word : ACCOUNT | COMMODITY | OTHER_WORD ;
commentText : (SPACE | SEMICOLON | DATE | word)* ;

commodityDirective : COMMODITY SPACE+ commodityString (SPACE* START_WITHIN_COMMENT commentText)? EOL ;
commodityString : multipleWords ;

transaction : DATE EOL ;

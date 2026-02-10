grammar Hledger;

COMMENT_BLOCK : 'comment' EOL .*? EOL 'end comment' EOL ;
COMMENT_LINE : '//' .*? EOL ;

SEMICOLON : ';' ;
EOL : '\r'? '\n' ;
SPACE : ' ' ;
SEP : SPACE SPACE+ ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
OTHER_WORD : ~[ ;\r\n]+ ;
DATE : [0-9] [0-9] [0-9] [0-9] '-' [0-9] [0-9] '-' [0-9] [0-9] ;


journal : (emptyLine | COMMENT_LINE | COMMENT_BLOCK | directive | transaction)* EOF ;

emptyLine : EOL ;

directive : (accountDirective | commodityDirective) ;

accountDirective : ACCOUNT SPACE accountName (SEP SEMICOLON commentText)? EOL ;
accountName : multipleWords ;
multipleWords : word (SPACE word)* ;
word : ACCOUNT | COMMODITY | OTHER_WORD ;
commentText : SPACE* word (SPACE+ word)* ;

commodityDirective : COMMODITY SPACE commodityString (SEP SEMICOLON commentText)? EOL ;
commodityString : multipleWords ;

transaction : DATE EOL ;

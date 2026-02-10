grammar Hledger;

COMMENT_BLOCK : COMMENT_START EOL .*? EOL COMMENT_END EOL ;
fragment
COMMENT_START : 'comment' ;
fragment
COMMENT_END : 'end comment' ;
EOL : '\r'? '\n' ;
SPACE : ' ' ;
SEP : SPACE SPACE+ ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
WORD : ~[ ;\r\n]+ ;
DATE : DIGIT DIGIT DIGIT DIGIT '-' DIGIT DIGIT '-' DIGIT DIGIT ;

fragment
DIGIT : [0-9] ;

journal : (emptyLine | commentLine | COMMENT_BLOCK | directive | transaction)* EOF ;

emptyLine : EOL ;
commentLine : '//' .*? EOL ;

directive : (accountDirective | commodityDirective) ;

accountDirective : ACCOUNT SPACE accountName (SEP ';' commentText)? EOL ;
accountName : multipleWords ;
multipleWords : WORD (SPACE WORD)* ;
commentText : SPACE* WORD (SPACE+ WORD)* ;

commodityDirective : COMMODITY SPACE commodityString (SEP ';' commentText)? EOL ;
commodityString : multipleWords ;

transaction : DATE EOL ;

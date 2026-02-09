grammar Hledger;

EOL : '\r'? '\n' ;
SPACE : ' ' ;
SEP : SPACE SPACE+ ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
WORD : ~[ ;\r\n]+ ;
DATE : DIGIT DIGIT DIGIT DIGIT '-' DIGIT DIGIT '-' DIGIT DIGIT ;

fragment
DIGIT : [0-9] ;

journal : (emptyLine | commentLine | commentBlock | directive | transaction)* EOF ;

emptyLine : EOL ;
commentLine : '//' .*? EOL ;
commentBlock : 'comment' EOL .*? EOL 'end comment' EOL ;

directive : (accountDirective | commodityDirective) ;

accountDirective : ACCOUNT SPACE accountName (SEP ';' commentText)? EOL ;
accountName : multipleWords ;
multipleWords : WORD (SPACE WORD)* ;
commentText : WORD (SPACE+ WORD)* ;

commodityDirective : COMMODITY SPACE commodityString (SEP ';' commentText)? EOL ;
commodityString : multipleWords ;

transaction : DATE EOL ;

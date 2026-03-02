grammar Hledger;

EOL : '\r'? '\n' ;
COMMENT_BLOCK : 'comment' EOL .*? EOL 'end comment' EOL -> channel(HIDDEN) ;
COMMENT_LINE : ('//' | '#') .*? EOL -> channel(HIDDEN) ;
INLINE_COMMENT : ' ' ' '+ ';' ~[\r\n]* -> channel(HIDDEN) ;
SEP : ' ' ' '+ ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
DATE : [0-9][0-9][0-9][0-9] [-./] [0-9][0-9] [-./] [0-9][0-9] ;
EQUALS : ' '* '=' ;
WORD : ~[ \r\n]+ ;
WS : [ \t]+ -> channel(HIDDEN) ;

journal : (emptyLine | directive | transaction)* EOF ;

emptyLine : EOL ;

directive : (accountDirective | commodityDirective) ;
accountDirective : ACCOUNT accountName EOL ;
accountName : (ACCOUNT | COMMODITY | WORD)+ ;
commodityDirective : COMMODITY commodity EOL ;
commodity : (ACCOUNT | COMMODITY | WORD)+ ;

transaction : DATE description EOL (SEP posting EOL)* ;
description : (SEP | ACCOUNT | COMMODITY | DATE | WORD)* ;
posting : accountName (SEP commodity)? assertion? ;
assertion : EQUALS commodity ;

grammar Hledger;

EOL : '\r'? '\n' ;
COMMENT_BLOCK : 'comment' EOL .*? EOL 'end comment' EOL -> channel(HIDDEN) ;
COMMENT_LINE : '//' .*? EOL -> channel(HIDDEN) ;
INLINE_COMMENT : ';' ~[\r\n]* -> channel(HIDDEN) ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
DATE : [0-9][0-9][0-9][0-9] [-./] [0-9][0-9] [-./] [0-9][0-9] ;
WORD : ~[ ;\r\n]+ ;
WS : [ \t]+ -> channel(HIDDEN) ;

journal : (emptyLine | directive | transaction)* EOF ;

emptyLine : EOL ;

directive : (accountDirective | commodityDirective) ;

accountDirective : ACCOUNT accountName EOL ;
accountName : WORD+ ;

commodityDirective : COMMODITY commodity EOL ;
commodity : WORD+ ;

transaction : DATE description? EOL ;
description : (';' | DATE | WORD)+ ;

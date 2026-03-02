grammar Hledger;

EOL : '\r'? '\n' ;
COMMENT_BLOCK : 'comment' EOL .*? EOL 'end comment' EOL -> channel(HIDDEN) ;
COMMENT_LINE : '//' .*? EOL -> channel(HIDDEN) ;
WITHIN_COMMENT : '  ;' .*? -> channel(HIDDEN) ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
DATE : [0-9]{4} [-./] [0-9]{2} [-./] [0-9]{2} ;
MULTIPLE_WORDS : SINGLE_WORD (SPACE SINGLE_WORD)* ;
fragment
SINGLE_WORD : ~[ ;\r\n]+ ;
SPACE : ' ' -> channel(HIDDEN) ;

journal : (directive | transaction)* EOF ;

directive : (accountDirective | commodityDirective) ;

accountDirective : ACCOUNT accountName EOL ;
accountName : MULTIPLE_WORDS ;

commodityDirective : COMMODITY commodity EOL ;
commodity : MULTIPLE_WORDS ;

transaction : DATE description EOL ;
description : (';' | DATE | MULTIPLE_WORDS)* ;

grammar Hledger;

EOL : '\r'? '\n' ;
COMMENT_BLOCK : 'comment' EOL .*? EOL 'end comment' EOL -> channel(HIDDEN) ;
COMMENT_LINE : '//' .*? EOL -> channel(HIDDEN) ;
WITHIN_COMMENT : '  ;' .*? -> channel(HIDDEN) ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
DATE : [0-9] [0-9] [0-9] [0-9] [-./] [01]? [0-9] [-./] [0-3]? [0-9] ;
MULTIPLE_WORDS : SINGLE_WORD (SPACE SINGLE_WORD)*
fragment
SINGLE_WORD : ~[ ;\r\n]+ ;
WS : ' ' -> channel(HIDDEN) ;

journal : (directive | transaction)* EOF ;

directive : (accountDirective | commodityDirective) ;

accountDirective : ACCOUNT accountName EOL ;
accountName : MULTIPLE_WORDS ;

commodityDirective : COMMODITY commodity EOL ;
commodity : MULTIPLE_WORDS ;

transaction : DATE description EOL ;
description : (SEMICOLON | DATE | MULTIPLE_WORDS)* ;

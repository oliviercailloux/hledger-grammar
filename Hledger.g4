grammar Hledger;

EOL : '\r'? '\n' ;
COMMENT_BLOCK : 'comment' EOL .*? EOL 'end comment' EOL -> channel(HIDDEN) ;
COMMENT_LINE : ('//' | '#') .*? EOL -> channel(HIDDEN) ;
INLINE_COMMENT : ' '+ ';' ~[\r\n]* -> channel(HIDDEN) ;
SEP : ' ' ' '+ ;
DECIMAL_MARK : 'decimal-mark .' ;
TAG : 'tag' ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
DATE : [0-9][0-9][0-9][0-9] [-./] [0-9][0-9] [-./] [0-9][0-9] ;
P_WORD : 'P' ' '+ ;
STAR : '*' ' '+ ;
EQUALS : ' '* '=' ;
WORD : ~[ \r\n]+ ;
WS : [ \t]+ -> channel(HIDDEN) ;

journal : (emptyLine | directive | transaction)* EOF ;

emptyLine : EOL ;

directive : (decimalMarkDirective | tagDirective | accountDirective | commodityDirective | pDirective) ;
decimalMarkDirective : DECIMAL_MARK EOL ;
tagDirective : TAG tag EOL ;
tag : WORD ;
accountDirective : ACCOUNT accountName EOL ;
accountName : (ACCOUNT | COMMODITY | WORD)+ ;
commodityDirective : COMMODITY commodity EOL ;
commodity : (ACCOUNT | COMMODITY | WORD)+ ;
pDirective : P_WORD DATE commoditySymbol commodityAmount EOL ;
commoditySymbol : WORD ;
commodityAmount : (ACCOUNT | COMMODITY | WORD)+ ;

transaction : DATE description EOL ((SEP posting)? EOL)* ;
description : (SEP | ACCOUNT | COMMODITY | DATE | P_WORD | STAR | EQUALS | WORD)* ;
posting : STAR? accountName (SEP commodity)? assertion? ;
assertion : EQUALS commodity ;

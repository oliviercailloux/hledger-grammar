grammar Hledger;

EOL : '\r'? '\n' ;
COMMENT_BLOCK : 'comment' EOL .*? (EOL 'end comment' EOL | EOF) -> channel(HIDDEN) ;
fragment RestOfLine : ~[\r\n]* ;
COMMENT_LINE : ('//' | '#' | ';') RestOfLine EOL -> channel(HIDDEN) ;
INLINE_COMMENT : ' '+ ';' RestOfLine -> channel(HIDDEN) ;
SEP : ' ' ' '+ ;
DECIMAL_MARK : 'decimal-mark .' ;
TAG : 'tag' ;
ACCOUNT : 'account' ;
COMMODITY : 'commodity' ;
DATE : [0-9][0-9][0-9][0-9] [-./] [0-9][0-9]? [-./] [0-9][0-9]? ;
P : 'P' ;
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
accountName : (ACCOUNT | COMMODITY | P | WORD)+ ;
commodityDirective : COMMODITY commodity EOL ;
commodity : (ACCOUNT | COMMODITY | P | WORD)+ ;
pDirective : P DATE commoditySymbol commodityAmount EOL ;
commoditySymbol : WORD ;
commodityAmount : (ACCOUNT | COMMODITY | P | WORD)+ ;

transaction : DATE description EOL ((SEP posting)? EOL)* ;
description : (SEP | ACCOUNT | COMMODITY | DATE | P | STAR | EQUALS | WORD)* ;
posting : STAR? accountName (SEP commodity)? assertion? ;
assertion : EQUALS commodity ;

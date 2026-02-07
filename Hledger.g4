grammar Hledger;

journal : (COMMENT_LINE | COMMENT_BLOCK | EMPTY_LINE | directive | transaction)* ;

COMMENT_LINE : '//' .*? '\r'? '\n' -> channel(HIDDEN) ;
COMMENT_BLOCK : 'comment' '\r'? '\n' .*? '\n' 'end comment' '\r'? '\n' -> channel(HIDDEN) ;
EMPTY_LINE : '\r'? '\n' -> channel(HIDDEN) ;

directive : .*? '\r'? '\n' ;
transaction : .*? '\r'? '\n' ;

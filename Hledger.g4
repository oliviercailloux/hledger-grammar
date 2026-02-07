grammar Hledger;

EOL : '\r'? '\n' ;
SPACE : ' ' ;
SEP : SPACE SPACE+ ;

journal : (directive)* ;

COMMENT_LINE : '//' .*? EOL -> channel(HIDDEN) ;
COMMENT_BLOCK : 'comment' EOL .*? '\n' 'end comment' EOL -> channel(HIDDEN) ;
EMPTY_LINE : EOL -> channel(HIDDEN) ;

directive : 'account' SPACE accountName (SEP ';' comment)? EOL ;
accountName : .*? ;
comment: .*? ;

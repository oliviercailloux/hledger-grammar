grammar Hledger;

EOL : '\r'? '\n' ;
SPACE : ' ' ;
SEP : SPACE SPACE+ ;
ACCOUNT : 'account' ;
WORD : ~[ ;\r\n]+ ;

journal : (emptyLine | commentLine | commentBlock | directive | transaction)* EOF ;

emptyLine : EOL ;
commentLine : '//' .*? EOL ;
commentBlock : 'comment' EOL .*? EOL 'end comment' EOL ;

directive : ACCOUNT SPACE accountName (SEP ';' commentText)? EOL ;
accountName : WORD (SPACE WORD)* ;
commentText : WORD (SPACE+ WORD)* ;

transaction : DIGIT EOL ;

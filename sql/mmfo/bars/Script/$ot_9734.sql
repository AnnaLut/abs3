
-----------   

update BARS.OP_FIELD set  DEFAULT_VALUE = 'SELECT name FROM fm_o_rep WHERE id=1' where TAG = 'O_REP' ;

update BARS.OP_FIELD set  DEFAULT_VALUE = 'SELECT name  FROM fm_yesno WHERE id=''NO'' ' where TAG = 'PUBLP' ;

COMMIT;

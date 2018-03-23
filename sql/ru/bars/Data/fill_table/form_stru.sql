
exec suda;

BEGIN

-- изменение описания показателей для #3B
DELETE FROM FORM_STRU WHERE KODF='3B' ;

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 1, 'Код~ ''LL'' ', 'substr(kodp,1,2)', '1', 4, 'G'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 2, '1-велике,среднє~2-мале під-во', 'substr(kodp,3,1)', '1', 3, 'G'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 3, 'Код~ "M" ', 'substr(kodp,4,1)', '1', 5, 'G'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 4, 'Код "K"~0-залишки~1-видатки~2-надходження', 'substr(kodp,5,1)', '1', 6, 'G'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 5, 'Код ~"DDDDD"', 'substr(kodp,6,5)', '1', 2, 'G');
 
INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 6, 'ідентифікаційний~номер', 'substr(kodp,11,10)', '1', 1, 'G'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 7, 'Значення~показника', 'znap', '0', NULL, 'G'); 

commit;
 
end;
/





exec suda;

BEGIN

-- ��������� �������� ����������� ��� #3B
DELETE FROM FORM_STRU WHERE KODF='3B' ;

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 1, '���~ ''LL'' ', 'substr(kodp,1,2)', '1', 4, 'G'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 2, '1-������,�����~2-���� ��-��', 'substr(kodp,3,1)', '1', 3, 'G'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 3, '���~ "M" ', 'substr(kodp,4,1)', '1', 5, 'G'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 4, '��� "K"~0-�������~1-�������~2-�����������', 'substr(kodp,5,1)', '1', 6, 'G'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 5, '��� ~"DDDDD"', 'substr(kodp,6,5)', '1', 2, 'G');
 
INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 6, '����������������~�����', 'substr(kodp,11,10)', '1', 1, 'G'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3B', 7, '��������~���������', 'znap', '0', NULL, 'G'); 

commit;
 
end;
/




-- � 01.01.2018 ����� ��������� ����� LDBBBBZLL��9�RQQVVVMMMN 
--                             ������ LDBBBBZLL�9�RQQVVVMMMN 

-- �������� K072 ����� ������������� 2-� ������� ������ ������������

exec bc.home;  

delete from form_stru where kodf = 'D6';


Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 1, '1-����,~2-%% ������)', 'substr(kodp,1,1)', '1', 
    'C', 12);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 2, '��� �������~�� �������~(1-���,2-���,6-���)', 'substr(kodp,2,1)', '1', 
    'C', 11);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 3, '���.~���.', 'substr(kodp,3,4)', '1', 
    'C', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 4, '��������~R011', 'substr(kodp,7,1)', '1', 
    'C', 3);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 5, '����i� ����~������i���~�i�������i~(K111)', 'substr(kodp,8,2)', '1', 
    'C', 4);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 6, '��� �������~������i��~(K072)', 'substr(kodp,10,2)', '1', 
    'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 7, '���~''9''', 'substr(kodp,12,1)', '1', 
    'C', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 8, '����������~�����~���������~(S183)', 'substr(kodp,13,1)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 9, '�������~��i���~(K030)', 'substr(kodp,14,1)', '1', 
    'C', 8);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 10, '���.-�������~�����~��������.~(K051)', 'substr(kodp,15,2)', '1', 
    'C', 9);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 11, '���~������~(R030)', 'substr(kodp,17,3)', '1', 
    'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 12, '���~�����~(K040)', 'substr(kodp,20,3)', '1', 
    'C', 10);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 13, '������� N~(2-�������~3-������� ���~4-����.�������)', 'substr(kodp,23,1)', '1', 
    'C', 13);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('D6', 14, '��� ������i~���������.�i�.', 'substr(nbuc,1,12)', '0', 
    'C');
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('D6', 15, '��������~���������', 'znap', '0', 
    'C');


commit;

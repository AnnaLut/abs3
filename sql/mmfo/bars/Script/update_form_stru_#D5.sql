-- � 01.01.2018 ����� ��������� ����� LDBBBBZLL��O�RQQ�VVVMMMT��NI 
--                             ������ LDBBBBZLL�O�RQQ�VVVMMMT��NI 

-- �������� K072 ����� ������������� 2-� ������� ������ ������������

exec bc.home;  

delete from form_stru where kodf = 'D5';

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 1, '1-����~2-%% ������', 'substr(kodp,1,1)', '1', 
    'C', 15);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 2, '��� �������~�� �������~(1-���,2-���,6-���)', 'substr(kodp,2,1)', '1', 
    'C', 14);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 3, '���.~���.', 'substr(kodp,3,4)', '1', 
    'C', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 4, '��������~R011', 'substr(kodp,7,1)', '1', 
    'C', 3);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 5, '��� ����~������i���~�i�������i~(K111)', 'substr(kodp,8,2)', '1', 
    'C', 4);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 6, '��� �������~������i��~(K072)', 'substr(kodp,10,2)', '1', 
    'C', 5);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 7, '��� ������~���''���� ����-�� (K140)', 'substr(kodp,12,1)', '1', 
    'C', 6);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 8, '����������~�����~���������~(S183)', 'substr(kodp,13,1)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 9, '�������~��i���~(K030)', 'substr(kodp,14,1)', '1', 
    'C', 8);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 10, '���.-�������~�����~��������.~(K051)', 'substr(kodp,15,2)', '1', 
    'C', 9);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 11, '������������~��� ��������.~(S032)', 'substr(kodp,17,1)', '1', 
    'C', 10);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 12, '���~������~(R030)', 'substr(kodp,18,3)', '1', 
    'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 13, '���~�����~(K040)', 'substr(kodp,21,3)', '1', 
    'C', 11);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 14, '����~��������~(S080)', 'substr(kodp,24,1)', '1', 
    'C', 12);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 15, '��� �i�i~����������~(S260)', 'substr(kodp,25,2)', '1', 
    'C', 13);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 16, '������� N~(2-�������~3-������� ���~4-����.������)', 'substr(kodp,27,1)', '1', 
    'C', 16);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 17, '��� ������~������������ �����~S190', 'substr(kodp,28,1)', '1', 
    'C', 17);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('D5', 18, '��� ������i~���������.�i�', 'substr(nbuc,1,12)', '0', 
    'C');
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('D5', 19, '��������~���������', 'znap', '0', 
    'C');

commit;

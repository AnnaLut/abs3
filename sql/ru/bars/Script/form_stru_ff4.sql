-- 12/06/2017 
-- ����� ��������� ����� �� 01.07.2017
-- ������ ����� ���������� ���~''9'' 
-- ����� ������������� �������� K140 (��� ������ ���'���� ��������������)

exec suda;

delete from form_stru where kodf = 'F4';

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 1, '1 - ����,~2 - %% ������', 'substr(kodp,1,1)', '1', 
    'C', 3);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 2, '5-�� ������~6-�� ������', 'substr(kodp,2,1)', '1', 
    'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 3, '���.~���.', 'substr(kodp,3,4)', '1', 
    'C', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 4, '��������~R013', 'substr(kodp,7,1)', '1', 
    'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 5, '��� ����ii~���� ������.~�i�������i', 'substr(kodp,8,1)', '1', 
    'C', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 6, '���~�������~������i��', 'substr(kodp,9,1)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 7, '��� �����������~������~���������', 'substr(kodp,10,1)', '1', 
    'C', 8);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 8, '�������~��i���', 'substr(kodp,11,1)', '1', 
    'C', 9);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 9, '��������~D020', 'substr(kodp,12,2)', '1', 
    'C', 10);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 10, '���~������', 'substr(kodp,14,3)', '1', 
    'C', 4);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 11, '��� ������~���''���� ��������������', 'substr(kodp,17,1)', '1', 
    'C', 11);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('F4', 12, '��� ���.~���������.�i�', 'substr(nbuc,1,12)', '0', 
    'C');
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('F4', 13, '�������� ���������', 'znap', '0', 
    'C');

commit;

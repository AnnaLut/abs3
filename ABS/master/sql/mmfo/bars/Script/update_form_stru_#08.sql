-- � 01.01.2018 ����� ��������� ����� DBBBBZ��RVVV���MMM 
--                             ������ DBBBBP�RVVV��� 

-- ������ ��������� R013 ����� ������������� �������� R011
-- �������� K072 ����� ������������� 2-� ������� ������ ������������
-- �������� ��� MMM - ��� �����

exec bc.home;  

delete from form_stru where kodf = '08';

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 1, '��� �������~(1 - ��,2 - ��)', 'substr(kodp,1,1)', '1', 
    'C', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 2, '���.~���.', 'substr(kodp,2,4)', '1', 
    'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 3, '�����.~R011', 'substr(kodp,6,1)', '1', 
    'C', 3);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 4, '��� �������~����.(K072)', 'substr(kodp,7,2)', '1', 
    'C', 4);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 5, '��������~�i���', 'substr(kodp,9,1)', '1', 
    'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 6, '���~������', 'substr(kodp,10,3)', '1', 
    'C', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 7, '��� �����������~������ ���������', 'substr(kodp,13,1)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 8, '��� ����~������ ������', 'substr(kodp,14,2)', '1', 
    'C', 8);
--------------------------------------------------------------------------
-- ���� ������� ����
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 9, '���~�����', 'substr(kodp,16,3)', '1', 
    'C', 9);
--------------------------------------------------------------------------
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('08', 10, '��� ������i~���������.�i�', 'substr(nbuc,1,12)', '0', 
    'C');
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('08', 11, '��������~���������', 'znap', '0', 
    'C');

commit;

-- � 01.01.2018 ����� ��������� ����� LDBBBBZ��VVV���MMMLNNNN 
--                             ������ DBBBBZ�VVV��� 

-- �������� ��� L - (1-����,2-�-���,3-��� ��)
-- �������� ��� MMM - ��� �����
-- �������� ��� L - ��� ������ �� ���������
-- �������� ��� NNNN - ���������� ����� ��

exec bc.home;  

delete from form_stru where kodf = '07';

-- ����� ���
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 1, '��� L~(1-����,2-�-���,3-��� ��)', 'substr(kodp,1,1)', '1', 
    'C', 3);
------------------------------------------------------------------------
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 2, '��� �������~(1 - ��,2 - ��)', 'substr(kodp,2,1)', '1', 
    'C', 4);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 3, '���.~���.', 'substr(kodp,3,4)', '1', 
    'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 4, '��������~R011', 'substr(kodp,7,1)', '1', 
    'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 5, '��� �������~����.(K072)', 'substr(kodp,8,2)', '1', 
    'C', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 6, '���~������', 'substr(kodp,10,3)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 7, '��� �����������~������ ���������', 'substr(kodp,13,1)', '1', 
    'C', 8);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 8, '��� ����~������ ������', 'substr(kodp,14,2)', '1', 
    'C', 9);
--------------------------------------------------------------------------
--��� ������� ����
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 9, '���~�����', 'substr(kodp,16,3)', '1', 
    'C', 10);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 10, '��� ������~�� ���������', 'substr(kodp,19,1)', '1', 
    'C', 11);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 11, '����������~����� ��', 'substr(kodp,20,4)', '1', 
    'C', 1);
--------------------------------------------------------------------------
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('07', 12, '��� ������i~���������.�i�', 'substr(nbuc,1,12)', '0', 
    'C');
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, A017)
 Values
   ('07', 13, '��������~���������', 'znap', 'C');

commit;


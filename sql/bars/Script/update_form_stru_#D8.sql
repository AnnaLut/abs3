-- �� 01.01.2018 ����� ��������� ���������� �
-- ����� ����������

exec bc.home;

Prompt NEW STRU FOR FILE #D8 );
-- ����� ��������� � 01.01.2018
-- ����������� ���� "H" - ��� ������ ���������� ������ (S083)
-- ����������� ���� "O" - ��� ������ ������ �������������� (K140) 

delete from form_stru where kodf = 'D8';

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 1, '���~DDD', 'substr(kodp,1,3)', '1', 
    'G', 3);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 2, '���~�����������', 'substr(kodp,4,10)', '1', 
    'G', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 3, 'N ����.~��������', 'substr(kodp,14,4)', '1', 
    'G', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 4, '���.~���.', 'substr(kodp,18,4)', '1', 
    'G', 4);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 5, '���~������', 'substr(kodp,22,3)', '1', 
    'G', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 6, '�����~������', 'substr(kodp,25,2)', '1', 
    'G', 6);
-- ����� ����� ���� ����������
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 7, '������~�������.����', 'substr(kodp,27,1)', '1', 
    'G', 7);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 8, '1-���. �� ���������~2-�� ���. �� ���������', 'substr(kodp,28,1)', '1', 
    'G', 8);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 9, '��� ����~������������', 'substr(kodp,29,2)', '1', 
    'G', 9);
---------------------------------------------------------------------------
�� 01.01.2018
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 10, '��� ������~���������� ������', 'substr(kodp,31,1)', '1', 
    'G', 10);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 11, '��� ������~������ ���-��', 'substr(kodp,32,1)', '1', 
    'G', 11);
---------------------------------------------------------------------------
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, A017)
 Values
   ('D8', 12, '��������~���������', 'znap', 'G');

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 13, '���', 'substr(kodp,31)', '0', 
    'G', 10);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 14, '���', 'nbuc', '0', 
    'G', 10);

commit;

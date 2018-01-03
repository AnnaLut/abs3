-- �� 01.01.2018 �������� ��������� ���������� ����� #26 
-- ��������� ����� ���������� 
--    �������� R011 
--    ������ ���������� ����� (��� J)
--    ��� ����������� ������ (�������� S181) 
--    ��� �������� ������ (�������� S245)
--    ��� �������� ������ �� ������� ������ (�������� S580) 

exec suda;

delete from form_stru where kodf = '26';

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 1, '���~"DD"', 'substr(kodp,1,2)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 2, '���~�����', 'substr(kodp,3,3)', '1', 
    'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 3, '���~�����', 'substr(kodp,6,10)', '1', 
    'C', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 4, '���.~���.', 'substr(kodp,16,4)', '1', 
    'C', 3);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 5, '��������~R011', 'substr(kodp,20,1)', '1', 
    'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 6, '��������~R013', 'substr(kodp,21,1)', '1', 
    'C', 6);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 7, '���~������', 'substr(kodp,22,3)', '1', 
    'C', 4);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 8, '������~����������', 'substr(kodp,25,1)', '1', 
    'C', 8);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 9, '��� �����������~������ ���������(S181)', 'substr(kodp,26,1)', '1', 
    'C', 9);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 10, '��� ��������~������ ���������(S245)', 'substr(kodp,27,1)', '1', 
    'C', 10);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 11, '��� ������ ��~������� ������(S580)', 'substr(kodp,28,1)', '1', 
    'C', 11);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('26', 12, '��������~���������', 'znap', '0', 
    'C');



commit;
-- �� 01.02.2018 ���� ��������� ���������

exec bc.home;

Prompt NEW STRU FOR FILE @77 );

delete from form_stru_int where kodf = '77';

Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 1, '1-��~2-��', 'substr(kodp,1,1)', '1', 
    '�', 1);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 2, '���.~���.', 'substr(kodp,2,4)', '1', 
    '�', 2);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 3, '��������~R011', 'substr(kodp,6,1)', '1', 
    '�', 5);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 4, '��������~R013', 'substr(kodp,7,1)', '1', 
    '�', 6);

Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 5, '1-����������.~2-��������.', 'substr(kodp,8,1)', '1', 
    '�', 4);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 6, '��� ������~�� ���������', 'substr(kodp,9,1)', '1', 
    '�', 7);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 7, '��������~�i���', 'substr(kodp,10,1)', '1', 
    '�', 8);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 8, '��� ������~������������~(s190)', 'substr(kodp,11,1)', '1', 
    '�', 9);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 9, '���~������', 'substr(kodp,12,3)', '1', 
    '�', 3);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, A017)
 Values
   ('77', 10, '��������~���������', 'znap', '�');


COMMIT;

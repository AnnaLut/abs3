PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/BARS/Script/UPD_FORM_STRU_#F8.sql =========*** Run
PROMPT ===================================================================================== 

--      ������ ��������� ����� #F8 

exec bc.home;

delete from form_stru where kodf = 'F8';

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 1, '���~"DD"', 'substr(kodp,1,2)', '1', 'C', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 2, '���~"CC"', 'substr(kodp,3,2)', '1', 'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 3, '��� ����~������~����-�~(�111)', 'substr(kodp,5,2)', '1', 'C', 3);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 4, '��� ���.~������.~�� ������~(S260)', 'substr(kodp,7,2)', '1', 'C', 4);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 5, '��� ����.~����~�����-��~(S032)', 'substr(kodp,9,1)', '1', 'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 6, '��� ���.~������~(S080)', 'substr(kodp,10,1)', '1', 'C', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 7, '��� ������~���.~���.�����~(S270)', 'substr(kodp,11,2)', '1', 'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 8, '���~������', 'substr(kodp,13,3)', '1', 'C', 8);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 9, '��� �i����.~������~�������.~(S245)', 'substr(kodp,16,1)', '1', 'C', 9);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, A017)
 Values
   ('F8', 10, '��������~���������', 'znap', 'C');

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========= Scripts /Sql/BARS/Script/UPD_FORM_STRU_#F8.sql =========*** End
PROMPT ===================================================================================== 

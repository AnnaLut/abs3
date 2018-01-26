PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/BARS/Script/UPD_FORM_STRU_#F8.sql =========*** Run
PROMPT ===================================================================================== 

--      замена структуры файла #F8 

exec bc.home;

delete from form_stru where kodf = 'F8';

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 1, 'Код~"DD"', 'substr(kodp,1,2)', '1', 'C', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 2, 'Код~"CC"', 'substr(kodp,3,2)', '1', 'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 3, 'Код виду~економ~дільн-ті~(К111)', 'substr(kodp,5,2)', '1', 'C', 3);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 4, 'Код інд.~спожив.~за цілями~(S260)', 'substr(kodp,7,2)', '1', 'C', 4);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 5, 'Код узаг.~виду~забез-ня~(S032)', 'substr(kodp,9,1)', '1', 'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 6, 'Код кат.~ризику~(S080)', 'substr(kodp,10,1)', '1', 'C', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 7, 'Код строку~пог.~осн.боргу~(S270)', 'substr(kodp,11,2)', '1', 'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 8, 'Код~валюти', 'substr(kodp,13,3)', '1', 'C', 8);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F8', 9, 'Код кiнцев.~строку~погашен.~(S245)', 'substr(kodp,16,1)', '1', 'C', 9);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, A017)
 Values
   ('F8', 10, 'Значення~показника', 'znap', 'C');

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========= Scripts /Sql/BARS/Script/UPD_FORM_STRU_#F8.sql =========*** End
PROMPT ===================================================================================== 

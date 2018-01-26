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

declare
  file_id_       number;
begin

    begin
      select nvl(id,0)  into  file_id_
        from nbur_ref_files
       where file_code ='#F8';
    exception
        when others then file_id_ :=0;
    end;

    if file_id_ !=0 then

       delete from nbur_ref_form_stru
        where file_id = file_id_;

        Insert into nbur_ref_form_stru
           (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, SORT_ATTRIBUTE)
         Values
           (file_id_, 1, 'Код~"DD"', 'substr(kodp,1,2)', '1', 1);
        Insert into nbur_ref_form_stru
           (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, SORT_ATTRIBUTE)
         Values
           (file_id_, 2, 'Код~"CC"', 'substr(kodp,3,2)', '1', 2);
        Insert into nbur_ref_form_stru
           (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, SORT_ATTRIBUTE)
         Values
           (file_id_, 3, 'Код виду~економ~дільн-ті~(К111)', 'substr(kodp,5,2)', '1', 3);
        
        Insert into nbur_ref_form_stru
           (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, SORT_ATTRIBUTE)
         Values
           (file_id_, 4, 'Код інд.~спожив.~за цілями~(S260)', 'substr(kodp,7,2)', '1', 4);
    
        Insert into nbur_ref_form_stru
           (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, SORT_ATTRIBUTE)
         Values
           (file_id_, 5, 'Код узаг.~виду~забез-ня~(S032)', 'substr(kodp,9,1)', '1', 5);
        Insert into nbur_ref_form_stru
           (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, SORT_ATTRIBUTE)
         Values
           (file_id_, 6, 'Код кат.~ризику~(S080)', 'substr(kodp,10,1)', '1', 6);
        Insert into nbur_ref_form_stru
           (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, SORT_ATTRIBUTE)
         Values
           (file_id_, 7, 'Код строку~пог.~осн.боргу~(S270)', 'substr(kodp,11,2)', '1', 7);
        Insert into nbur_ref_form_stru
           (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, SORT_ATTRIBUTE)
         Values
           (file_id_, 8, 'Код~валюти', 'substr(kodp,13,3)', '1', 8);
    
        Insert into nbur_ref_form_stru
           (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, SORT_ATTRIBUTE)
         Values
           (file_id_, 9, 'Код кiнцев.~строку~погашен.~(S245)', 'substr(kodp,16,1)', '1', 9);
        
        Insert into nbur_ref_form_stru
           (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE)
         Values
           (file_id_, 10, 'Значення~показника', 'znap');
    
    end if;
    commit;

end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========= Scripts /Sql/BARS/Script/UPD_FORM_STRU_#F8.sql =========*** End
PROMPT ===================================================================================== 

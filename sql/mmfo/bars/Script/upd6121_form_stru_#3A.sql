-- на 27.12.2017 меняется структура файла #3A 
-- вместо параметра R013 должен формироваться параметр R011

exec bc.home;

update form_stru set name='Параметр~R011'
where kodf = '3A' and natr = 4;

commit;

delete from BARS.NBUR_REF_FORM_STRU where file_id = 15165;
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 1, NULL, '1 - сума,~2 - %% ставка', 'substr(kodp,1,1)', 
    '1', 8);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 2, NULL, '5-Дт оборот~6-Кт оборот', 'substr(kodp,2,1)', 
    '1', 2);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 3, NULL, 'Бал.~рах.', 'substr(kodp,3,4)', 
    '1', 1);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 4, NULL, 'Параметр~R011', 'substr(kodp,7,1)', 
    '1', 4);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 5, NULL, 'Код початкового~строку~погашення', 'substr(kodp,8,1)', 
    '1', 5);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 6, NULL, 'Резиден~тнiсть', 'substr(kodp,9,1)', 
    '1', 6);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 7, NULL, 'Параметр~D020', 'substr(kodp,10,2)', 
    '1', 7);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 8, NULL, 'Код~валюти', 'substr(kodp,12,3)', 
    '1', 3);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 9, NULL, 'Тип~інструменту', 'substr(kodp,15,1)', 
    '1', 9);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 10, NULL, 'Код обл.~безбаланс.вiд', 'substr(nbuc,1,12)', 
    '0', NULL);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 11, NULL, 'Значення показника', 'znap', 
    '0', NULL);
COMMIT;

exec bc.home;

SET DEFINE OFF;

delete from BARS.NBUR_REF_FORM_STRU where file_id = 17052;
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 1, '1 - сума,~2 - %% ставка', 'substr(kodp,1,1)', '1', 
    10);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 2, '5-Дт оборот~6-Кт оборот', 'substr(kodp,2,1)', '1', 
    2);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 3, 'Бал.~рах.', 'substr(kodp,3,4)', '1', 
    1);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 4, 'Параметр~R013', 'substr(kodp,7,1)', '1', 
    4);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 5, 'Код секцii~виду економ.~дiяльностi', 'substr(kodp,8,1)', '1', 
    5);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 6, 'Код~сектора~економiки', 'substr(kodp,9,1)', '1', 
    6);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 7, 'Код початкового~строку~погашення', 'substr(kodp,10,1)', '1', 
    7);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 8, 'Резиден~тнiсть', 'substr(kodp,11,1)', '1', 
    8);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 9, 'Параметр~D020', 'substr(kodp,12,2)', '1', 
    9);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 10, 'Код~валюти', 'substr(kodp,14,3)', '1', 
    3);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 11, 'Код розміру~суб''єкта господарювання', 'substr(kodp,17,1)', '1', 
    11);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE)
 Values
   (17052, 12, 'Код обл.~безбаланс.вiд', 'substr(nbuc,1,12)', '0');
   
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE)
 Values
   (17052, 13, 'Значення показника', 'znap', '0');
COMMIT;

exec bc.home;

SET DEFINE OFF;

delete from BARS.NBUR_REF_FORM_STRU where file_id = 17052;
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 1, '1 - ����,~2 - %% ������', 'substr(kodp,1,1)', '1', 
    10);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 2, '5-�� ������~6-�� ������', 'substr(kodp,2,1)', '1', 
    2);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 3, '���.~���.', 'substr(kodp,3,4)', '1', 
    1);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 4, '��������~R013', 'substr(kodp,7,1)', '1', 
    4);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 5, '��� ����ii~���� ������.~�i�������i', 'substr(kodp,8,1)', '1', 
    5);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 6, '���~�������~������i��', 'substr(kodp,9,1)', '1', 
    6);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 7, '��� �����������~������~���������', 'substr(kodp,10,1)', '1', 
    7);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 8, '�������~��i���', 'substr(kodp,11,1)', '1', 
    8);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 9, '��������~D020', 'substr(kodp,12,2)', '1', 
    9);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 10, '���~������', 'substr(kodp,14,3)', '1', 
    3);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (17052, 11, '��� ������~���''���� ��������������', 'substr(kodp,17,1)', '1', 
    11);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE)
 Values
   (17052, 12, '��� ���.~���������.�i�', 'substr(nbuc,1,12)', '0');
   
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE)
 Values
   (17052, 13, '�������� ���������', 'znap', '0');
COMMIT;

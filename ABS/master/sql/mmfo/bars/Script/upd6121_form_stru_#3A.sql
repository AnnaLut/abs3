-- �� 27.12.2017 �������� ��������� ����� #3A 
-- ������ ��������� R013 ������ ������������� �������� R011

exec bc.home;

update form_stru set name='��������~R011'
where kodf = '3A' and natr = 4;

commit;

delete from BARS.NBUR_REF_FORM_STRU where file_id = 15165;
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 1, NULL, '1 - ����,~2 - %% ������', 'substr(kodp,1,1)', 
    '1', 8);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 2, NULL, '5-�� ������~6-�� ������', 'substr(kodp,2,1)', 
    '1', 2);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 3, NULL, '���.~���.', 'substr(kodp,3,4)', 
    '1', 1);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 4, NULL, '��������~R011', 'substr(kodp,7,1)', 
    '1', 4);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 5, NULL, '��� �����������~������~���������', 'substr(kodp,8,1)', 
    '1', 5);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 6, NULL, '�������~��i���', 'substr(kodp,9,1)', 
    '1', 6);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 7, NULL, '��������~D020', 'substr(kodp,10,2)', 
    '1', 7);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 8, NULL, '���~������', 'substr(kodp,12,3)', 
    '1', 3);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 9, NULL, '���~�����������', 'substr(kodp,15,1)', 
    '1', 9);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 10, NULL, '��� ���.~���������.�i�', 'substr(nbuc,1,12)', 
    '0', NULL);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (15165, 11, NULL, '�������� ���������', 'znap', 
    '0', NULL);
COMMIT;

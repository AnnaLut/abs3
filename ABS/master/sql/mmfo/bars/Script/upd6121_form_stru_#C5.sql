-- �� 27.12.2017 (�� 26.12.2017) �������� ��������� ����� #C5 
-- � ��������� ���������� �������� ����� ����������
-- �������� R011, �������� S245, �������� K077
-- ��������� �������� R012 

exec suda;

delete from form_stru where kodf = 'C5';


Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 1, '1-��~2-��', 'substr(kodp,1,1)', '1', 
    'G', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 2, '���.~���.', 'substr(kodp,2,4)', '1', 
    'G', 2);

--���� ������� ����
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 3, '��������~R011', 'substr(kodp,6,1)', '1', 
    'G', 3);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 4, '��������~R013', 'substr(kodp,7,1)', '1', 
    'G', 4);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 5, '���~������', 'substr(kodp,8,3)', '1', 
    'G', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 6, '�������~������~(S580)', 'substr(kodp,11,1)', '1', 
    'G', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 7, '���~����������~(R017)', 'substr(kodp,12,1)', '1', 
    'G', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 8, '������~����������', 'substr(kodp,13,3)', '1', 
    'G', 8);

--���� ������� ����
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 9, '���~�������� ������~(S245)', 'substr(kodp,16,1)', '1', 
    'G', 9);
--���� ������� ����
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 10, '���~������������ �������~(K077)', 'substr(kodp,17,1)', '1', 
    'G', 10);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, A017)
 Values
   ('C5', 11, '��������~���������', 'znap', 'G');

commit;

    
delete from BARS.NBUR_REF_FORM_STRU where file_id = 16753;
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (16753, 1, NULL, '1-��~2-��', 'substr(kodp,1,1)', 
    '1', 1);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (16753, 2, NULL, '���.~���.', 'substr(kodp,2,4)', 
    '1', 2);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (16753, 3, NULL, '��������~R011', 'substr(kodp,6,1)', 
    '1', 3);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (16753, 4, NULL, '��������~R013', 'substr(kodp,7,1)', 
    '1', 4);   
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (16753, 5, NULL, '���~������', 'substr(kodp,8,3)', 
    '1', 5);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (16753, 6, NULL, '�������~������~(S580)', 'substr(kodp,11,1)', 
    '1', 6);      
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (16753, 7, NULL, '���~����������~(R017)', 'substr(kodp,12,1)', 
    '1', 7);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (16753, 8, NULL, '������~����������', 'substr(kodp,13,3)', 
   '1', 8);
   
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (16753, 9, NULL, '���~�������� ������~(S245)', 'substr(kodp,16,1)', 
    '1', 9);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (16753, 10, NULL, '���~������������ �������~(K077)', 'substr(kodp,17,1)', 
    '1', 10);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, 
    KEY_ATTRIBUTE, SORT_ATTRIBUTE)
 Values
   (16753, 11, NULL, '��������~���������', 'znap', 
    NULL, NULL);
COMMIT;

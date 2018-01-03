-- �� 27.12.2017 (�� 26.12.2017) �������� ��������� ����� #A7 
-- � ��������� ���������� ��������� ����� ����������
-- �������� R011, �������� S190
-- ��������� �������� R012 

exec suda;

delete from form_stru where kodf = 'A7';


Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('A7', 1, '1-��~2-��', 'substr(kodp,1,1)', '1', 'G', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('A7', 2, '���.~���.', 'substr(kodp,2,4)', '1', 'G', 2);

--���� ������� ����
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('A7', 3, '��������~R011', 'substr(kodp,6,1)', '1', 'G', 3);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('A7', 4, '��������~R013', 'substr(kodp,7,1)', '1', 'G', 4);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('A7', 5, '1-����������.~2-��������.', 'substr(kodp,8,1)', '1', 'G', 5);
   
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('A7', 6, '��� ������~�� ���������', 'substr(kodp,9,1)', '1', 'G', 6);
   
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('A7', 7, '��������~�i���', 'substr(kodp,10,1)', '1', 'G', 7);

--���� ������� ����
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('A7', 8, '��� ������~�������������~(S190)', 'substr(kodp,11,1)', '1',  'G', 8);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('A7', 9, '���~������', 'substr(kodp,12,3)', '1', 'G', 9);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, A017)
 Values
   ('A7', 10, '��������~���������', 'znap', 'G');

commit;

delete from BARS.NBUR_REF_FORM_STRU where FILE_ID = 16555;
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (16555, 1, '1-��~2-��', 'substr(kodp,1,1)', '1', 
    1);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (16555, 2, '���.~���.', 'substr(kodp,2,4)', '1', 
    2);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (16555, 3, '��������~R011', 'substr(kodp,6,1)', '1', 
    3);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (16555, 4, '��������~R013', 'substr(kodp,7,1)', '1', 
    4); 
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (16555, 5, '1-����������.~2-��������.', 'substr(kodp,8,1)', '1', 
    5);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (16555, 6, '��� �����~�� ���������', 'substr(kodp,9,1)', '1', 
    6);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (16555, 7, '��������~�i���', 'substr(kodp,10,1)', '1', 
    7);
    
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (16555, 8, '��� ������~�������������~(S190)', 'substr(kodp,11,1)', '1', 
    8);
    
--���� ������� ����
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, 
    SORT_ATTRIBUTE)
 Values
   (16555, 9, '���~������', 'substr(kodp,12,3)', '1', 
    9);
Insert into BARS.NBUR_REF_FORM_STRU
   (FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE)
 Values
   (16555, 10, '��������~���������', 'znap');
COMMIT;

exec nbur_files.SET_FILE_VIEW(16555);

commit;
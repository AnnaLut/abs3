-- 05/07/2017 
-- ����� ��������� ����� �� 01.07.2017
-- ������ ����� ���������� ���~''9'' 
-- ����� ������������� �������� K140 (��� ������ ���'���� ��������������)

exec bc.home;

update BARS.FORM_STRU set name = '��� ������~���''���� ��������������'
where kodf='D5' and natr = 7;

commit;

update BARS.NBUR_REF_FORM_STRU set Segment_name = '��� ������~���''���� ��������������'
where file_id=16853 and segment_number = 7;

commit;


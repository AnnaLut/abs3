PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_79X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_79X ***

create or replace view v_nbur_79X as
select
          v.REPORT_DATE
          , v.KF
          , v.VERSION_ID
          , extractValue(COLUMN_VALUE, 'DATA/EKP') as EKP
          , extractValue(COLUMN_VALUE, 'DATA/R030') as R030
          , extractValue(COLUMN_VALUE, 'DATA/K030') as K030
          , extractValue(COLUMN_VALUE, 'DATA/Q001') as Q001
          , extractValue(COLUMN_VALUE, 'DATA/K020') as K020
          , extractValue(COLUMN_VALUE, 'DATA/K021') as K021
          , extractValue(COLUMN_VALUE, 'DATA/Q007_1') as Q007_1
          , extractValue(COLUMN_VALUE, 'DATA/Q007_2') as Q007_2
          , extractValue(COLUMN_VALUE, 'DATA/Q007_3') as Q007_3
          , extractValue(COLUMN_VALUE, 'DATA/Q007_4') as Q007_4
          , extractValue(COLUMN_VALUE, 'DATA/Q003_1') as Q003_1
          , extractValue(COLUMN_VALUE, 'DATA/Q003_2') as Q003_2
          , extractValue(COLUMN_VALUE, 'DATA/Q003_3') as Q003_3
          , extractValue(COLUMN_VALUE, 'DATA/T070_1') as T070_1
          , extractValue(COLUMN_VALUE, 'DATA/T070_2') as T070_2
          , extractValue(COLUMN_VALUE, 'DATA/T070_3') as T070_3
          , extractValue(COLUMN_VALUE, 'DATA/T070_4') as T070_4
          , extractValue(COLUMN_VALUE, 'DATA/T090_1') as T090_1
          , extractValue(COLUMN_VALUE, 'DATA/T090_2') as T090_2
    from  NBUR_REF_FILES f
          , NBUR_LST_FILES v
          , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
   where  f.ID        = v.FILE_ID
          and f.FILE_CODE = '79X'
          and f.FILE_FMT  = 'XML'
          and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED');
           
comment on table V_NBUR_79X is '���� 79X - ���� ��� ����������� ������ �� ��������� ���������� �����';
comment on column V_NBUR_79X.REPORT_DATE is '��i��� ����';
comment on column V_NBUR_79X.KF is '�i�i�';
comment on column V_NBUR_79X.VERSION_ID is '����� ���� �����';
comment on column V_NBUR_79X.EKP    is '��� ���������';
comment on column V_NBUR_79X.R030   is '��� ������ ��������������� �����';
comment on column V_NBUR_79X.K030   is '��� ������������ ���������';
comment on column V_NBUR_79X.Q001   is '����� ������������ �������� ����� ��� �������, ���, �� ������� ������� ����� ���������';
comment on column V_NBUR_79X.K020   is '��� ���������';
comment on column V_NBUR_79X.K021   is '��� ������ �����������������/������������� ����/������';
comment on column V_NBUR_79X.Q007_1 is '���� ��������� ����� ��� �������������� ����';
comment on column V_NBUR_79X.Q007_2 is '���� ��������� 䳿 ����� ��� �������������� ����';
comment on column V_NBUR_79X.Q007_3 is '���� ������ ������� � ������ ������� �� ����������� �������� ����� ��� ��������� �� �������';
comment on column V_NBUR_79X.Q007_4 is '���� ��������� ��������';
comment on column V_NBUR_79X.Q003_1 is '����� ������ ������� � ������ ������� �� ����������� �������� ����� ��� ��������� �� �������';
comment on column V_NBUR_79X.Q003_2 is '����� ��������� ��������';
comment on column V_NBUR_79X.Q003_3 is '������� ���������� ����� ����� ��� ����������� ���������';
comment on column V_NBUR_79X.T070_1 is '���� ���������� ��������������� ����� ��� ���������� �� ������� ����� �� �/� 3660,3661';
comment on column V_NBUR_79X.T070_2 is '����, �� ��� �������� ����� �� ���������� ��������� ����� �� ������ ��������������� ����� �� ������� �����';
comment on column V_NBUR_79X.T070_3 is '���� ��������������� �����, ��� ����������� � ���������� ������������� ������� �����';
comment on column V_NBUR_79X.T070_4 is '���� ����������� ���������, ������������� ������� 3.10 ����� 3 ������ III ���������� � 368';
comment on column V_NBUR_79X.T090_1 is '�������, ���� �������� �� ���������� ���� ��������������� �����';
comment on column V_NBUR_79X.T090_2 is '����� ��������� ������, ��� �������������� �� �������������� ������, ����� � ������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_79X.sql =========*** End *** =
PROMPT ===================================================================================== 

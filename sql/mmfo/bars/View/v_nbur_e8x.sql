PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_e8x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_e8x ***

create or replace view v_nbur_e8x as
select
          v.REPORT_DATE
          , v.KF
          , v.VERSION_ID
          , lpad(extractValue(COLUMN_VALUE, 'DATA/Q003_12'), 10 , '0') as FIELD_CODE
          , extractValue(COLUMN_VALUE, 'DATA/EKP') as EKP
          , extractValue(COLUMN_VALUE, 'DATA/T070_1') as T070_1
          , extractValue(COLUMN_VALUE, 'DATA/T070_2') as T070_2
          , extractValue(COLUMN_VALUE, 'DATA/T070_3') as T070_3
          , extractValue(COLUMN_VALUE, 'DATA/T070_4') as T070_4
          , extractValue(COLUMN_VALUE, 'DATA/T090') as T090
          , extractValue(COLUMN_VALUE, 'DATA/K040') as K040
          , extractValue(COLUMN_VALUE, 'DATA/KU_1') as KU_1
          , extractValue(COLUMN_VALUE, 'DATA/K014') as K014
          , extractValue(COLUMN_VALUE, 'DATA/K110') as K110
          , extractValue(COLUMN_VALUE, 'DATA/K074') as K074
          , extractValue(COLUMN_VALUE, 'DATA/R030') as R030
          , extractValue(COLUMN_VALUE, 'DATA/R020') as R020
          , extractValue(COLUMN_VALUE, 'DATA/Q020') as Q020
          , extractValue(COLUMN_VALUE, 'DATA/Q003_12') as Q003_12
          , extractValue(COLUMN_VALUE, 'DATA/Q001') as Q001
          , extractValue(COLUMN_VALUE, 'DATA/K020') as K020
          , extractValue(COLUMN_VALUE, 'DATA/Q029') as Q029
          , extractValue(COLUMN_VALUE, 'DATA/Q003_1') as Q003_1
          , extractValue(COLUMN_VALUE, 'DATA/Q003_2') as Q003_2
          , extractValue(COLUMN_VALUE, 'DATA/Q007_1') as Q007_1
          , extractValue(COLUMN_VALUE, 'DATA/Q007_2') as Q007_2
          , extractValue(COLUMN_VALUE, 'DATA/K021') as K021
    from  NBUR_REF_FILES f
          , NBUR_LST_FILES v
          , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
   where  f.ID        = v.FILE_ID
          and f.FILE_CODE = 'E8X'
          and f.FILE_FMT  = 'XML'
          and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED');
           
comment on table V_NBUR_E8X is '���� E8X - ��� ��� ����������� ������ �� ��������� ���������� �����';
comment on column V_NBUR_E8X.REPORT_DATE is '��i��� ����';
comment on column V_NBUR_E8X.KF is '�i�i�';
comment on column V_NBUR_E8X.VERSION_ID is '����� ���� �����';
comment on column V_NBUR_E8X.EKP is '��� ���������';
comment on column V_NBUR_E8X.T070_1 is '������� ���� �����';
comment on column V_NBUR_E8X.T070_2 is '������������� �������/�����';
comment on column V_NBUR_E8X.T070_3 is '��������� �������';
comment on column V_NBUR_E8X.T070_4 is '���������� (��������/������)';
comment on column V_NBUR_E8X.T090 is '����� ��������� ������';
comment on column V_NBUR_E8X.K040 is '��� ����� ���������';
comment on column V_NBUR_E8X.KU_1 is '��� ������, � ����� ������������� ��������';
comment on column V_NBUR_E8X.K014 is '��� ���� �볺��� �����';
comment on column V_NBUR_E8X.K110 is '��� ���� ��������� �������� ���������';
comment on column V_NBUR_E8X.K074 is '��� �������������� ������� ��������';
comment on column V_NBUR_E8X.R030 is '��� ������';
comment on column V_NBUR_E8X.R020 is '����� ����������� �������';
comment on column V_NBUR_E8X.Q020 is '��� ���� ���''����� � ������ �����';
comment on column V_NBUR_E8X.Q003_12 is '������� ���������� ����� ������ � ������� ����';
comment on column V_NBUR_E8X.Q001 is '������������ ���������';
comment on column V_NBUR_E8X.K020 is '���������������� ��� ���������';
comment on column V_NBUR_E8X.Q029 is '��� ��������� - ����������� ��� ���� � ����� �������� ��� ���������� ������������ ������';
comment on column V_NBUR_E8X.Q003_1 is '������� ���������� ����� �������� � ������� ����';
comment on column V_NBUR_E8X.Q003_2 is '����� ��������';
comment on column V_NBUR_E8X.Q007_1 is '���� �������� ��� ���� ������� ���� �����';
comment on column V_NBUR_E8X.Q007_2 is '���� �������� ��������� �������������';
comment on column V_NBUR_E8X.K021 is '��� ������ ����������������� ���� ���������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_e8x.sql =========*** End *** =
PROMPT ===================================================================================== 
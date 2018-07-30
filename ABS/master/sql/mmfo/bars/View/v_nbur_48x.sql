PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_48x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_48x ***

create or replace view v_nbur_48x 
as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , t.Q003 as FIELD_CODE
       , t.EKP
       , t.Q003
       , t.Q001
       , t.Q002
       , t.Q008
       , t.Q029
       , t.K020
       , t.K021
       , t.K040
       , t.K110
       , t.T070
       , t.T080
       , t.T090_1
       , t.T090_2
       , t.T090_3
from   (
         select
                v.REPORT_DATE
                , v.KF
                , v.version_id
                , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
                , extractValue( COLUMN_VALUE, 'DATA/Q003'  ) as Q003
                , extractValue( COLUMN_VALUE, 'DATA/Q001'  ) as Q001
                , extractValue( COLUMN_VALUE, 'DATA/Q002'  ) as Q002
                , extractValue( COLUMN_VALUE, 'DATA/Q008'  ) as Q008
                , extractValue( COLUMN_VALUE, 'DATA/Q029'  ) as Q029
                , extractValue( COLUMN_VALUE, 'DATA/K020'  ) as K020
                , extractValue( COLUMN_VALUE, 'DATA/K021'  ) as K021
                , extractValue( COLUMN_VALUE, 'DATA/K040'  ) as K040
                , extractValue( COLUMN_VALUE, 'DATA/K110'  ) as K110
                , extractValue( COLUMN_VALUE, 'DATA/T070'  ) as T070
                , extractValue( COLUMN_VALUE, 'DATA/T080'  ) as T080
                , extractValue( COLUMN_VALUE, 'DATA/T090_1'  ) as T090_1
                , extractValue( COLUMN_VALUE, 'DATA/T090_2'  ) as T090_2
                , extractValue( COLUMN_VALUE, 'DATA/T090_3'  ) as T090_3
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '48X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_48X is '48X �������� ��������� �������� �����';
comment on column V_NBUR_48X.REPORT_DATE is '����� ����';
comment on column V_NBUR_48X.KF is '��� �i�i��� (���)';
comment on column V_NBUR_48X.VERSION_ID is '��. ���� �����';
comment on column V_NBUR_48X.NBUC is '��� ������ ����� � ������� ����';
comment on column V_NBUR_48X.FIELD_CODE is '��� ���������';
comment on column V_NBUR_48X.EKP is '��� ���������';
comment on column V_NBUR_48X.Q003 is '������� ���������� ����� �������� �����';
comment on column V_NBUR_48X.Q001 is '����� ������������ �������� ����� ��� �������, ���, �� ������� ������� ����� �������� �����';
comment on column V_NBUR_48X.Q002 is '������ �������� ����� ��� ������ ��������� ���� ���������� ������� �����';
comment on column V_NBUR_48X.Q008 is '������ �������� �������� ����� ��� �������� ��� ������� �����';
comment on column V_NBUR_48X.Q029 is '��� �������� ����� ����������� ��� ���� � ����� �������� ��� ���������� ������������ ������';
comment on column V_NBUR_48X.K020 is '��� �������� �����';
comment on column V_NBUR_48X.K021 is '��� ������ �����������������/������������� ����/������';
comment on column V_NBUR_48X.K040 is '��� ����� �������� �����';
comment on column V_NBUR_48X.K110 is '��� ���� ��������� �������� �������� �����';
comment on column V_NBUR_48X.T070 is '������� ����� (���)';
comment on column V_NBUR_48X.T080 is 'ʳ������ ����� (���)';
comment on column V_NBUR_48X.T090_1 is '³������ ����� ����� � ���������� ������';
comment on column V_NBUR_48X.T090_2 is '³������ �������������� ����� � ���������� ������';
comment on column V_NBUR_48X.T090_3 is '³������ �������� ����� � ���������� ������';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_48x.sql =========*** End *** =
PROMPT ===================================================================================== 